terraform {
  backend "s3" {
    bucket         = "company-terraform-state-12345-example"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
