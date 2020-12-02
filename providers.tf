##################################################################
# Provider Group database.
##################################################################

provider "aws" {
  alias      = "us-east-2"
  region     = "us-east-2"
}

##################################################################
# Provider Autoscalling Group and Load Balancer.
##################################################################

provider "aws" {
  alias      = "us-east-1"
  region     = "us-east-1"
}

##################################################################
# Provider default.
##################################################################

provider "aws" {
  region  = "us-east-1"
}