resource "aws_elb" "gorilla-web-elb" {
  name = "gorilla-web-elb"
  internal = false
  subnets = [
    aws_subnet.gorilla-vpc-public.id]
  security_groups = [
    aws_security_group.gorilla-web-lb-sg.id]
  tags = {
    Environment = "prd"
  }
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = aws_acm_certificate.gorilla-test-cert-request.id
  }
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold   = 10
    interval            = 30
    target              = "TCP:80"
    timeout             = 10
    unhealthy_threshold = 10
  }
  instances = [
    aws_instance.gorilla-web.id]
}

resource "aws_route53_record" "gorilla-web-elb" {
  zone_id = aws_route53_zone.gorilla-test-com.id
  name    = "timeoff"
  type    = "CNAME"
  ttl     = "60"
  records = [
    aws_elb.gorilla-web-elb.dns_name
  ]
}
