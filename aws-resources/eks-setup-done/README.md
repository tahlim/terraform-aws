# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

1. clone
2. terraform apply
3. terraform state list : this is the file that stores the resource information that has to be deployed
4. terraform output kubeconfig

=> now i am going to redirect kubeconfig file to my home directory

5. terraform output kubeconfig > ~/.kube/config
6. download iam aws authenticator

kubectl cluster-info
