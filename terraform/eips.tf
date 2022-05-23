resource "aws_eip" "gorilla-vpc-private-nat-eip" {
  vpc = true
}