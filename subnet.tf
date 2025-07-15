resource "aws_subnet" "Project_public_subnet" {
count = length(var.public_subnet_cidr)
vpc_id    =   aws_vpc.Project_vpc.id
cidr_block = var.public_subnet_cidr[count.index]
map_public_ip_on_launch = true
availability_zone = var.availability_zone[count.index]
tags = {
  Name = "public_subnet-${count.index + 1}"
}
}

resource "aws_subnet" "Project_pvt_subnet" {
#count = length(var.availability_zone)
vpc_id    =   aws_vpc.Project_vpc.id
cidr_block = var.pvt_subnet_cidr
map_public_ip_on_launch = false
availability_zone = var.availability_zone-pvt
tags = {
  Name = "pvt_subnet"
}
}