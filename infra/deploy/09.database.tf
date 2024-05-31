#######################
# Database - Postgres #
#######################

resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${local.prefix}-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      aws_security_group.ecs_service.id
    ]
  }

  tags = {
    Name = "${local.prefix}-db-security-group"
  }
}

resource "aws_db_instance" "main" {
  identifier        = "${local.prefix}-db"
  db_name           = "ot"
  allocated_storage = 20
  engine                     = "postgres"
  engine_version             = "16.2"
  instance_class             = "db.t4g.micro"
  port                       = "5432"
  # storage_type               = "gp2"
  username                   = var.db_username
  password                   = var.db_password
  db_subnet_group_name       = aws_db_subnet_group.main.name
  vpc_security_group_ids     = [aws_security_group.rds.id]
  auto_minor_version_upgrade = true
  skip_final_snapshot        = true
  multi_az                   = false
  # 
  backup_retention_period    = 0
  backup_window              = "03:00-04:00"
  maintenance_window         = "sun:08:00-sun:09:00"

  depends_on = [
    aws_db_subnet_group.main
  ]

  tags = {
    Name = "${local.prefix}-main"
  }
}
