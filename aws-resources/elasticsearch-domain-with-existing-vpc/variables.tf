variable "aws_region" {
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

variable "domain" {
  description = "The name of the Elasticsearch Domain"
  default     = "elasticsearch-domain-test"
}

