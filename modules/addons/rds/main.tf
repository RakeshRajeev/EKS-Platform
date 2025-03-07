resource "aws_db_instance" "eks_db" {
  identifier           = "${var.cluster_name}-db"
  engine              = "postgres"
  engine_version      = "13.7"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  
  db_name             = "eksdb"
  username            = var.db_username
  password            = var.db_password
  
  vpc_security_group_ids = [var.rds_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.eks_db.name
  
  skip_final_snapshot    = true
  
  tags = {
    Environment = "dev"
    Cluster     = var.cluster_name
  }
}

resource "aws_db_subnet_group" "eks_db" {
  name       = "${var.cluster_name}-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.cluster_name}-db-subnet-group"
  }
}
