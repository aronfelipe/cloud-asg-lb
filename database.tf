##############################################################
# EC2 Database.
##############################################################

module "db" {
  source = "terraform-aws-modules/ec2-instance/aws"

  providers = {
    aws = aws.us-east-2
  }

  instance_count = 1

  name          = "PostgreSQL"
  ami           = data.aws_ami.ubuntu_ohio.id
  instance_type = "t2.large"
  subnet_id     = tolist(data.aws_subnet_ids.database.ids)[0]
  vpc_security_group_ids      = [module.database_security_group.this_security_group_id]
  
  associate_public_ip_address = true

  user_data_base64 = base64encode(local.user_data_database)

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}