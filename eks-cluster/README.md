# Provision an EKS Cluster

Terraform configuration files to provision an EKS cluster on AWS.

terraform plan -out terraform.plan
terraform apply terraform.plan

- On eks is deployed, run the following command to retrieve the access credentials for your cluster and configure
$ aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
