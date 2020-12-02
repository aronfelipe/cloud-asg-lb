##################################################################
# Security Group database.
##################################################################

module "database_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  providers = {
    aws = aws.us-east-2
  }

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.database.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["postgresql-tcp"]
  egress_rules        = ["all-all"]
}

##################################################################
# Security Group web server.
##################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  providers = {
    aws = aws.us-east-1
  }

  name        = "security_group_webserver"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-5000-tcp"]
  egress_rules        = ["all-all"]
}

