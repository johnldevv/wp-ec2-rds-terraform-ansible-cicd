output "ec2_public_ip" {
  value = aws_instance.wp_server.public_ip
}

output "db_endpoint" {
  value = aws_db_instance.wp_db.endpoint
}


