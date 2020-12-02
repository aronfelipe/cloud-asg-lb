##################################################################
# Launch configuration and autoscaling group.
##################################################################

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "deployer"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUav5e59nrtmeVuHET9VBHUngY7yW0Dk6deoWRHeIsL4/1Jrs9TCAP2Ix+FqQz1mFeCzSRFydooUNQ0NqoUfLY5atDB104IYm0RlppPZSOJFJVIPYefNKDVsYYdVXfuCaSW52AyWUpuYt0cO4sRQqZGPjurOy2xPW4TP/cybiu5+YC13l9A3DsYEsWfYif4+lkrEOnt47MBbIAx1oSHEwKP9EhZofNg8Qb/DO6vISILCJ07QyNIHxcMbwth4ejslrjMCZjCMJe/sBuGO5fYDhKV9FUSgPHCLRFo8l5WMaeDyrdb8EkujckFf30dr1zjA0ookEAqVplr+iW6RRI2Ftr felipe@felipe-340XAA-350XAA-550XAA"

}