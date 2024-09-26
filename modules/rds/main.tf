resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_sub_name
  subnet_ids = [var.pri_sub_5a_id, var.pri_sub_6b_id] # Replace with your private subnet IDs
}

resource "aws_db_instance" "db" {
  identifier              = "foodshopdb-instance"
  engine                  = "mysql"
  engine_version          = "5.7.44"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = true
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.db_sg_id] # Replace with your desired security group ID

  db_subnet_group_name = aws_db_subnet_group.db-subnet.name

  tags = {
    Name = "foodshopdb"
  }
}

# resource "null_resource" "setup_db" {
#   depends_on = [aws_db_instance.db]

#   provisioner "local-exec" {
#     command = <<EOL
#       sudo mysql -h ${aws_db_instance.db.address} -u ${var.db_username} -p${var.db_password} < ./modules/rds/setup.sql
#     EOL
#   }
# }