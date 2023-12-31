#--------------------|
#----LOAD BALANCER---|
#--------------------|
resource "aws_lb" "alb" {
  name               = "${local.NAME_PREFIX_DEV}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.subnets[*].id
  enable_deletion_protection = false
  
  tags = local.COMMON_TAGS
}

resource "aws_lb_target_group" "alb" {
  name     = "${local.NAME_PREFIX_DEV}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }

  tags = local.COMMON_TAGS
}