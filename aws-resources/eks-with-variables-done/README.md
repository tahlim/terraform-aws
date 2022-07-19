# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

1. clone
2. terraform apply
3. terraform state list : this is the file that stores the resource information that has to be deployed
4. terraform output kubeconfig

=> download iam aws authenticator, CLI, kubectl before kubeconfig configuration.

================================================

# 1. Install the AWS CLI on Linux

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
./aws/install -i /usr/local/aws-cli -b /usr/local/bin
aws --version

# 2. Install kubectl

curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.4/2021-07-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
kubectl
kubectl version --short --client

# 3. Installing aws-iam-authenticator for eks
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator &&  mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin && echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
- aws-iam-authenticator help

kubectl cluster-info

aws eks --region us-east-1 describe-cluster --name Dmat-onp-cluster --query cluster.status
aws eks --region us-east-1 update-kubeconfig --name Dmat-onp-cluster
kubectl get svc
