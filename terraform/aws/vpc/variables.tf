////////////////////////////////
// AWS Connection

variable "aws_profile" {}

variable "aws_region" {}

////////////////////////////////
// Tags

variable "tag_customer" {}

variable "tag_project" {}

variable "tag_name" {}

variable "tag_dept" {}

variable "tag_contact" {}

variable "tag_application" {}

variable "tag_ttl" {
  default = 3600
}
