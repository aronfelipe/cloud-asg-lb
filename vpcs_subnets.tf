##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "database" {
  provider = aws.us-east-2
  default = true
}

data "aws_subnet_ids" "database" {
  provider = aws.us-east-2
  vpc_id = data.aws_vpc.database.id
}

##############################################################
# Data sources to get VPC, subnets and security group details for Load Balancer and Auto Scallign Group.
##############################################################

data "aws_vpc" "default" {
  provider = aws.us-east-1
  default = true
}

data "aws_subnet_ids" "all" {
  provider = aws.us-east-1
  vpc_id = data.aws_vpc.default.id
}