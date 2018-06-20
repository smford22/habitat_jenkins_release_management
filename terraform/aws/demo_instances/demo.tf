data "template_file" "hab_sup_initd" {
  template = "${file("${path.module}/../templates/hab_sup_initd")}"

  vars {
    channel = "${var.channel}"
  }
}

resource "aws_instance" "aws-amazon-linux-production" {
  connection {
    user        = "ec2-user"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${aws_security_group.base_linux.id}", "${aws_security_group.habitat_supervisor.id}"]
  associate_public_ip_address = true

  tags {
    Name          = "aws_amazon_production_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    destination = "/tmp/hab-sup"
    content     = "${data.template_file.hab_sup_initd.rendered}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostname aws-amazon-linux-${var.prod_channel}",
      "sudo cp /tmp/hab-sup /etc/init.d/hab-sup",
      "sudo chmod 755 /etc/init.d/hab-sup",
    ]

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.aws_amazon_image_user}"
      private_key = "${file("${var.aws_key_pair_file}")}"
    }
  }

  provisioner "habitat" {
    use_sudo     = true
    service_type = "unmanaged"

    service {
      name     = "jonlives/chef-base"
      channel  = "${var.prod_channel}"
      strategy = "at-once"
    }

    service {
      name     = "scottford/np-mongodb"
      channel  = "${var.prod_channel}"
      strategy = "at-once"
    }

    service {
      name     = "scottford/national-parks"
      binds    = ["database:np-mongodb.default"]
      channel  = "${var.prod_channel}"
      strategy = "at-once"
    }

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("${var.aws_key_pair_file}")}"
    }
  }
}