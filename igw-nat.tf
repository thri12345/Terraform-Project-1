resource "aws_internet_gateway" "project_vpc-igw" {
  vpc_id = aws_vpc.Project_vpc.id
  tags = {
    Name    = "project-igw"
  }
}

resource "aws_eip" "project_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "project_nat" {
  #count = length(var.public_subnet_cidr)
  allocation_id = aws_eip.project_eip.id
  subnet_id     = aws_subnet.Project_public_subnet[0].id
  tags = {
    Name = "project-nat"
  }
  
}