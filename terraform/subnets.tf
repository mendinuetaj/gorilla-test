resource "aws_subnet" "gorilla-vpc-public" {
  vpc_id = aws_vpc.gorilla_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "gorilla-vpc-public"
  }
}

resource "aws_subnet" "gorilla-vpc-private" {
  vpc_id = aws_vpc.gorilla_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "gorilla-vpc-private"
  }
}


resource "aws_route_table_association" "loyality-public-crt-loyality-vpc-public-1" {
  route_table_id = aws_route_table.gorilla-public-rt.id
  subnet_id = aws_subnet.gorilla-vpc-public.id
}


resource "aws_route_table_association" "loyality-private-1-crt-loyality-vpc-private-1" {
  route_table_id = aws_route_table.gorilla-private-rt.id
  subnet_id = aws_subnet.gorilla-vpc-private.id
}

