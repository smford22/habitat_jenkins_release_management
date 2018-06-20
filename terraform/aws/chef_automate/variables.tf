////////////////////////////////
// AWS Connection

variable "aws_profile" {}

variable "aws_region" {}

////////////////////////////////
// Server Settings
variable "aws_centos_image_user" {
  default = "centos"
}

variable "aws_image_user" {
  default = "ec2-user"
}

////////////////////////////////
// Tags

variable "tag_customer" {}

variable "tag_project" {}

variable "tag_name" {}

variable "tag_dept" {}

variable "tag_contact" {}

variable "tag_application" {}

variable "tag_ttl" {}

variable "aws_key_pair_file" {}

variable "aws_key_pair_name" {}

variable "automate_server_instance_type" {}

variable "vpc_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

////////////////////////////////
// Habitat

variable "channel" {}

////////////////////////////////
// Automate License

variable "automate_license" {
  default = "Contact Chef Sales at sales@chef.io to request a license."
}
