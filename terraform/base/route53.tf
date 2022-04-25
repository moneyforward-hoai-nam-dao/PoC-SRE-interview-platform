resource "aws_route53_zone" "primary" {
  name = "example.com"

  vpc {
    vpc_id = aws_vpc.this.id
  }
}

resource "aws_route53_record" "cname_route53_record" {
  zone_id = aws_route53_zone.primary.zone_id
  type    = "CNAME"
  ttl     = 60
  name    = "test.example.com"
  records = [aws_lb.alb.dns_name]
}
