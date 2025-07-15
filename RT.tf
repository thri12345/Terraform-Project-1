resource "aws_route_table" "project-public-rt" {
vpc_id = aws_vpc.Project_vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_vpc-igw.id
    
}
  tags = {
    Name = "project-pub-route-trable"
  }
}

resource "aws_route_table_association" "project-public" {
    count = length(var.public_subnet_cidr)
    subnet_id = aws_subnet.Project_public_subnet[count.index].id
    route_table_id = aws_route_table.project-public-rt.id
}

resource "aws_route_table" "project-pvt-rt" {
vpc_id = aws_vpc.Project_vpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.project_nat.id
    
}
  tags = {
    Name = "project-pvt-route-trable"
  }
}

resource "aws_route_table_association" "project-pvt" {
   
    subnet_id = aws_subnet.Project_pvt_subnet.id
    route_table_id = aws_route_table.project-pvt-rt.id
}