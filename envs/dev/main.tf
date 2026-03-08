
// The local block will create a variable called name_prefix that concatenates the project and environment variables. 
//This can be used to create unique resource names across different environments.
locals {
  name_prefix = "${var.project}-${var.env}"
}


// The vpc module will create a VPC with the specified CIDR block and availability zones.
// The values are passed here using the local.name_prefix variable to ensure that the VPC name is unique across different environments.

module "vpc" {
  source      = "D:\\TerraformProjects\\Advanced-Lab\\Multi-Env\\modules\\vpc"
  name_prefix = "${local.name_prefix}-vpc"
  cidr_block  = "10.50.0.0/16"
  az_count    = 2
}


// The below is the ec2 module called
// The ec2 module will create an EC2 instance with the specified instance type, AMI ID, and subnet ID.
// The values are passed here using the local.name_prefix variable to ensure that the EC2 instance
module "ec2" {
  source        = "D:\\TerraformProjects\\Advanced-Lab\\Multi-Env\\modules\\ec2"
  name_prefix   = "${local.name_prefix}-ec2"
  instance_type = "t3.micro"
  ami_id        = "ami-0c94855ba95c71c99" // Amazon Linux 2 AMI (HVM), SSD Volume Type
  subnet_id     = module.vpc.public_subnet_ids[0]
}


module "s3" {
  source      = "D:\\TerraformProjects\\Advanced-Lab\\Multi-Env\\modules\\s3"
  bucket_name = "${local.name_prefix}-bucket"
}