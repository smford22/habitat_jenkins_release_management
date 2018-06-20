data "template_file" "install_chef_automate_cli" {
  template = "${file("${path.module}/../templates/install_chef_automate_cli.sh.tpl")}"

  vars {
    channel = "${var.channel}"
  }
}

resource "aws_instance" "chef_automate" {
  connection {
    user        = "${var.aws_centos_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                    = "${data.aws_ami.centos.id}"
  instance_type          = "${var.automate_server_instance_type}"
  key_name               = "${var.aws_key_pair_name}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.chef_automate.id}"]
  ebs_optimized          = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 100
    volume_type           = "gp2"
  }

  tags {
    Name          = "${format("chef_automate_${random_id.instance_id.hex}")}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

  provisioner "file" {
    destination = "/tmp/install_chef_automate_cli.sh"
    content     = "${data.template_file.install_chef_automate_cli.rendered}"
  }


  provisioner "file" {
    source      = "files/config2.toml"
    destination = "/tmp/config.toml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname a2demo.jonliv.es",
      "sudo sysctl -w vm.max_map_count=262144",
      "sudo sysctl -w vm.dirty_expire_centisecs=20000",
      "curl https://packages.chef.io/files/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip |gunzip - > chef-automate && chmod +x chef-automate",
      "sudo chmod +x /tmp/install_chef_automate_cli.sh",
      "sudo bash /tmp/install_chef_automate_cli.sh",
      "sudo mv /tmp/config.toml /etc/chef-automate/config.toml",
      "sudo ./chef-automate deploy /etc/chef-automate/config.toml --accept-terms-and-mlsa",
      "sudo cat /home/centos/automate-credentials.toml",
    ]
  }
}
