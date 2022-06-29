terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_security_group" "testsg" {   #two types se existing SG ko use kr sakte hi, first data blocks se or second variables
  id = "sg-01f0092c8aaea9ea3"
  }

data "aws_subnet_ids" "public" {
  vpc_id = "${var.cidr_block}"
#  id = "subnet-01f6e73b11f8d02c3"
}

resource "aws_elasticsearch_domain" "test" {
  domain_name           = var.domain
  elasticsearch_version = "7.1"
  cluster_config {
    instance_type       = "r5.large.elasticsearch"
  }
  vpc_options {
    subnet_ids          = [data.aws_subnet_ids.public.id]
#    subnet_ids          = "${var.subnet.id}"
    security_group_ids  = [data.aws_security_group.testsg.id]
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = "test_master_user"
      master_user_password = "Barbarbarbar1!"
    }
  }
  encrypt_at_rest {
    enabled = true
  }
  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  node_to_node_encryption {
    enabled = true
  }
  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
  access_policies = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "*"
          },
          "Action": "es:*",
          "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
        }
    ]
}
POLICY
}
