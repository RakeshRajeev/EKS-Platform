resource "aws_db_instance" "eks_db" {
  count = var.db_username != null && var.db_password != null && var.rds_security_group_id != null ? 1 : 0

  identifier           = "${var.cluster_name}-db"
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "13.7"
  instance_class      = "db.t3.micro"
  db_name             = "eksdb"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true

  vpc_security_group_ids = compact([var.rds_security_group_id])
  db_subnet_group_name   = aws_db_subnet_group.eks_db[0].name

  tags = {
    Environment = "dev"
    Cluster     = var.cluster_name
  }
}

resource "aws_db_subnet_group" "eks_db" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  name       = "${var.cluster_name}-db-subnet"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.cluster_name}-db-subnet"
  }
}

output "db_endpoint" {
  value = try(aws_db_instance.eks_db[0].endpoint, null)
}
