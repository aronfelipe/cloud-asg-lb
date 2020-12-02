##################################################################
# Ubuntu 18.04 most recent AMI in us-east-2
##################################################################

data "aws_ami" "ubuntu_ohio" {
  most_recent = true

  provider = aws.us-east-2

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

##################################################################
# Ubuntu 18.04 most recent AMI in us-east-1
##################################################################

data "aws_ami" "ubuntu_north_virginia" {
  most_recent = true

  provider = aws.us-east-1

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}