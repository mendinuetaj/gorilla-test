//////////////////////////////////////////////////////////////////////
resource "aws_instance" "gorilla-web" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = 20
  }
  volume_tags = {
    Name = "gorilla-web_vol"
  }
  subnet_id              = aws_subnet.gorilla-vpc-private.id
  vpc_security_group_ids = [
    aws_security_group.gorilla-web-sg.id
  ]
  key_name = aws_key_pair.gorilla-keypair.key_name
  tags     = {
    Name = "gorilla-web"
    app  = "time-off"
  }
}
resource "aws_route53_record" "gorilla-web" {
  zone_id = aws_route53_zone.gorilla-test-com.id
  name    = aws_instance.gorilla-web.tags.Name
  type    = "A"
  ttl     = "60"
  records = [
    aws_instance.gorilla-web.private_ip
  ]
}
//////////////////////////////////////////////////////////////////////
resource "aws_instance" "gorilla-jumphost" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  root_block_device {
    volume_size = 20
  }
  volume_tags = {
    Name = "gorilla-jumphost_volume"
  }
  subnet_id              = aws_subnet.gorilla-vpc-public.id
  vpc_security_group_ids = [
    aws_security_group.gorilla-jumphost-sg.id
  ]
  key_name = "gorilla-keypair"
  tags     = {
    Name = "gorilla-jumphost"
    app  = "bastion"
  }
}
resource "aws_route53_record" "gorilla-jumphost" {
  zone_id = aws_route53_zone.gorilla-test-com.id
  name    = aws_instance.gorilla-jumphost.tags.Name
  type    = "A"
  ttl     = "60"
  records = [
    aws_eip.gorilla-vpc-private-nat-eip.public_ip
  ]
}