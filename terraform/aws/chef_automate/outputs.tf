output "chef_automate_server_public_ip" {
  value = "${aws_instance.chef_automate.public_ip}"
}
