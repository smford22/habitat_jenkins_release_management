terraform {
  required_version = "= 0.11.7" // Terraform frequently puts breaking changes into minor and patch version releases. _Always_ hard pin to the latest known and tested working version. Do not trust semantic versioning.
}

provider "aws" {
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
}

resource "random_id" "instance_id" {
  byte_length = 4
}

resource "aws_vpc" "habichef-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name          = "${var.tag_name}-vpc"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Contact     = "${var.tag_contact}"
    X-Application = "${var.tag_application}"
    X-TTL         = "${var.tag_ttl}"
  }
}

resource "aws_internet_gateway" "habichef-gateway" {
  vpc_id = "${aws_vpc.habichef-vpc.id}"

  tags {
    Name = "habichef-gateway"
  }
}

resource "aws_route" "habichef-internet-access" {
  route_table_id         = "${aws_vpc.habichef-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.habichef-gateway.id}"
}

resource "aws_subnet" "habichef-subnet" {
  vpc_id                  = "${aws_vpc.habichef-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "habichef-subnet"
  }
}
