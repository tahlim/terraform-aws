resource "aws_default_vpc" "default" {
tags = {
Name = "Default VPC"
  }
}
# Creating a new security group for EC2 instance with ssh and http and EFS inbound rules
resource "aws_security_group" "ec2_security_group" {
name        = "ec2_security_group"
description = "Allow SSH and HTTP"
vpc_id      = aws_default_vpc.default.id
ingress {
description = "SSH from VPC"
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
description = "EFS mount target"
from_port   = 2049
to_port     = 2049
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
description = "HTTP from VPC"
from_port   = 80
to_port     = 80
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }
egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
  }
}
