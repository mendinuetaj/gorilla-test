resource "aws_security_group" "gorilla-web-sg" {
  vpc_id = aws_vpc.gorilla_vpc.id
  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    security_groups = [
      aws_security_group.gorilla-web-lb-sg.id
    ]
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }

  ingress {
    security_groups = [
      aws_security_group.gorilla-jumphost-sg.id
    ]
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }
}

resource "aws_security_group" "gorilla-web-lb-sg" {
  vpc_id = aws_vpc.gorilla_vpc.id
  name   = "gorilla-web-lb-sg"
  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "gorilla-jumphost-sg" {
  vpc_id = aws_vpc.gorilla_vpc.id
  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "167.0.175.91/32"]
  }
  tags = {
    Name = "gorilla-jumphost-sg"
  }
}