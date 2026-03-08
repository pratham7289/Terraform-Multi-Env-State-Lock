locals {
  name_prefix = "${var.project}-${var.env}"
}

module "vpc" {
  source   = "../../modules/vpc"
  name     = "${local.name_prefix}-vpc"
  cidr     = "10.50.100.0/16"  # Production CIDR
  az_count = 3                  # More AZs for prod
}

module "ec2" {
  source        = "../../modules/ec2"
  name          = "${local.name_prefix}-toolbox"
  ami           = "ami-08c40ec9ead489470" # Update to prod AMI if needed
  instance_type = "t3.medium"            # Bigger instance for prod
  subnet_id     = module.vpc.public_subnet_ids[0]
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = "${local.name_prefix}-bucket-12345-prod"
}
