resource "aws_nat_gateway" "gorilla-vpc-private-nat" {
  allocation_id = aws_eip.gorilla-vpc-private-nat-eip.id
  subnet_id = aws_subnet.gorilla-vpc-public.id
  depends_on = [
    aws_internet_gateway.gorilla-igw]
  tags = {
    Name = "gorilla-natgw"
  }
}
