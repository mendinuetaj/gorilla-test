resource "aws_route_table" "gorilla-public-rt" {
  vpc_id = aws_vpc.gorilla_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gorilla-igw.id
  }
  tags = {
    Name = "loyality-public-crt"
  }
}

resource "aws_route_table" "gorilla-private-rt" {
  vpc_id = aws_vpc.gorilla_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gorilla-vpc-private-nat.id
  }
  tags = {
    Name = "gorilla-private-rt"
  }
}

