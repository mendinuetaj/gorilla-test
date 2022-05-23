resource "aws_acm_certificate" "gorilla-test-cert-request" {
  domain_name               = aws_route53_zone.gorilla-test-com.name
  subject_alternative_names = [
    "timeoff.${aws_route53_zone.gorilla-test-com.name}"
  ]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Environment = "prd"
  }
}


resource "aws_route53_record" "existing" {
  for_each = {
    for dvo in aws_acm_certificate.gorilla-test-cert-request.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.gorilla-test-com.zone_id
}

resource "aws_acm_certificate_validation" "existing" {
  certificate_arn         = aws_acm_certificate.gorilla-test-cert-request.arn
  validation_record_fqdns = [for record in aws_route53_record.existing : record.fqdn]
}



