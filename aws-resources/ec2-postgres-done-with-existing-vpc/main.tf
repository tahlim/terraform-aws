# Provider configuration: plugin that Terraform uses to
provider "aws" {
  region = var.aws_region
}


  data "aws_security_group" "testsg" {   #two types se existing SG ko use kr sakte hi, first data blocks se or second variables
    id = "sg-01f0092c8aaea9ea3"
  }


# PostgreSQL DB Instance
resource "aws_instance" "web" {
  ami           = "ami-00b21f32c4929a15b" # Amazon Linux 2 ARM
  instance_type = var.instance_type
  key_name = "terraform"
  user_data = templatefile("install_postgres.sh", {
    pg_hba_file = templatefile("pg_hba.conf", { allowed_ip = "0.0.0.0/0" }),
  })

  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    delete_on_termination = true
    volume_size   = 10
}

  subnet_id                   = "${var.subnet}"
  vpc_security_group_ids      = [data.aws_security_group.testsg.id]
#  vpc_security_group_ids      = "${var.security_groups}"
  tags = {
    Name = "PostgreSQL"
  }
}

# Show the public IP of the newly created instance
output "instance_ip_addr" {
  value = aws_instance.web.*.public_ip
}

