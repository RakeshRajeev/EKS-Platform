resource "aws_db_instance" "postgres" {
  engine            = "postgres"
  engine_version    = "14"
  instance_class    = "db.t3.medium"
  allocated_storage = 20
  identifier        = "eks-microservices-db"
  username         = "admin"
  password         = "securepassword"
}
