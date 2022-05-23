resource "aws_internet_gateway" "gorilla-igw" {
  vpc_id = aws_vpc.gorilla_vpc.id
  tags = {
    Name = "gorilla-igw"
  }
}