output "vpc_id" {
  value = "${aws_vpc.habichef-vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.habichef-subnet.id}"
}
