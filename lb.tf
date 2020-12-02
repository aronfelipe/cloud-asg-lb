##############################################################
# ELB.
##############################################################

module "elb" {
  source = "terraform-aws-modules/elb/aws"
  depends_on = [module.security_group]

  providers = {
    aws = aws.us-east-1
  }

  name = "asg-load-balancer"

  subnets         = data.aws_subnet_ids.all.ids
  security_groups = [module.security_group.this_security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = "5000"
      instance_protocol = "HTTP"
      lb_port           = "5000"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:5000/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}