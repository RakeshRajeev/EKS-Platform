resource "aws_db_instance" "main" {
  identifier        = "${var.cluster_name}-db"
  engine           = "postgres"
  engine_version   = "12.15"  # Changed to definitely supported version
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [var.rds_security_group_id]
  db_subnet_group_name  = aws_db_subnet_group.main.name

  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.cluster_name}-db-subnet"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.cluster_name}-db-subnet"
  }
}

output "db_endpoint" {
  value = try(aws_db_instance.main.endpoint, null)
}
