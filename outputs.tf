output "website_url" {
  value = aws_instance.web.public_ip
}