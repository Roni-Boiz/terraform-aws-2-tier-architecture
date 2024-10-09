output "db_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "db_host" {
  value = aws_db_instance.db.address
}

output "db_port" {
  value = aws_db_instance.db.port
}

output "db_username" {
  value = aws_db_instance.db.username
}

output "db_password" {
  value = aws_db_instance.db.password
}

output "db_name" {
  value = aws_db_instance.db.db_name
}