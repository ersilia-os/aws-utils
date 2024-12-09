terraform {
  backend "s3" {
    bucket         = "terraform-backend-terraformbackends3bucket-ryoml6i8ojgf"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-1WXVHPC5Q1SO1"
    encrypt        = true
  }
}