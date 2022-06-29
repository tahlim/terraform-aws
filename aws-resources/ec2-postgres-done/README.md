useful command that we have, format and indent the Terraform configuration files properly:

$ terraform init

$ terraform fmt

To verify that our scripts are syntactically correct:

$ terraform validate

Success! The configuration is valid.
Before we create the resources in AWS, we can see what’s the Terraform plan by running:

$ terraform plan

$ terraform apply -auto-approve

$ terraform state list
