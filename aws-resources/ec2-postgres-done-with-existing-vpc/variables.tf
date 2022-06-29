variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "cidr_block" {
  default = "demo"
}
variable "subnet" {
  default = "subnet-01f6e73b11f8d02c3"
}

variable "aws_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "instance_type" {
  type    = string
  default = "t4g.micro"
}

# variable "security_groups" {
#  type    = string
#  default = "sg-01f0092c8aaea9ea3"
#}
