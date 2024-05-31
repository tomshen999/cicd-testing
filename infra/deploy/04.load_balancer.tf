#################
# Load Balancer #
#################

resource "aws_security_group" "lb" {
  description = "Configure access for the Application Load Balancer"
  name        = "${local.prefix}-alb-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5051
    to_port     = 5051
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5488
    to_port     = 5488
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5051
    to_port     = 5051
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5488
    to_port     = 5488
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress {
  #   from_port   = 8000
  #   to_port     = 8000
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}

resource "aws_lb" "api" {
  name               = "${local.prefix}-lb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  security_groups    = [aws_security_group.lb.id]
}

# ===================== api-sys ========================
resource "aws_lb_target_group" "api-sys" {
  name        = "${local.prefix}-api-sys"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  port        = 5050

  # health_check {
  #   path = "/api-sys/health-check/"
  # }
}

resource "aws_lb_listener" "api-sys" {
  load_balancer_arn = aws_lb.api.arn
  port              = 5050
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api-sys.arn
  }
}

# ===================== api-app ========================
resource "aws_lb_target_group" "api-app" {
  name        = "${local.prefix}-api-app"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  port        = 5051

  # health_check {
  #   path = "/api-app/health-check/"
  # }
}

resource "aws_lb_listener" "api-app" {
  load_balancer_arn = aws_lb.api.arn
  port              = 5051
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api-app.arn
  }
}


# ====================================================
resource "aws_lb_target_group" "report" {
  name        = "${local.prefix}-report"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  port        = 5488

  # health_check {
  #   path = "/report/health-check/"
  # }
}

resource "aws_lb_listener" "report" {
  load_balancer_arn = aws_lb.api.arn
  port              = 5488
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.report.arn
  }
}
