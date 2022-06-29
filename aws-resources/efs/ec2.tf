# Generate new private key
resource "tls_private_key" "my_key" {
algorithm = "RSA"
}
# Generate a key-pair with above key
resource "aws_key_pair" "deployer" {
key_name   = "efs-key"
public_key = tls_private_key.my_key.public_key_openssh
}
# Saving Key Pair for ssh login for Client if needed
resource "null_resource" "save_key_pair"  {
provisioner "local-exec" {
command = "echo  ${tls_private_key.my_key.private_key_pem} > mykey.pem"
}
}

# Creating EC2 instance
resource "aws_instance" "web" {
ami           = "ami-0cff7528ff583bf9a"
instance_type = "t2.micro"
key_name = aws_key_pair.deployer.key_name
security_groups = [aws_security_group.ec2_security_group.name]
tags = {
Name = "WEB"
 }
provisioner "local-exec" {
command = "echo ${aws_instance.web.public_ip} > publicIP.txt"
  }


connection {
type = "ssh"
user = "ec2-user"
private_key = file("/home/ubuntu/terraform/terraform-aws/aws-resources/efs/mykey.pem")              # file("F:/terraform-workstation/terraform-key.pem")
host  = aws_instance.web.public_ip
}

provisioner "remote-exec" {
inline = [
"sudo yum install httpd php git -y -q ",
"sudo systemctl start httpd",
"sudo systemctl enable httpd",
"sudo yum install nfs-utils -y -q ", # Amazon ami has pre installed nfs utils
# Mounting Efs
"sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
# Making Mount Permanent
"echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab " ,
"sudo chmod go+rw /var/www/html",
"sudo git clone https://github.com/Apeksh742/EC2_instance_with_terraform.git /var/www/html",
  ]
 }
}
