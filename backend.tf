terraform {
  backend "s3" {
    bucket         = "terraform-github-runner-tf-state-backend"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking-table"
    encrypt        = true
  }
}