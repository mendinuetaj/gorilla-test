//STG VPC
resource "aws_vpc" "gorilla_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "true"
  instance_tenancy = "default"
  tags = {
    Name = "gorilla-prd-vpc"
  }
}

