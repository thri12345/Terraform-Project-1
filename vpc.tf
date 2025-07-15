resource "aws_vpc" "Project_vpc" {
cidr_block       = var.vpc_cidr
tags = {
    Name = "project_vpc"
}
  
}