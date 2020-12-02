##################################################################
# Launch configuration and autoscaling group.
##################################################################

resource "aws_launch_configuration" "launch_configuration" {
  provider = aws.us-east-1
  name          = "webserver_config"
  image_id      = data.aws_ami.ubuntu_north_virginia.id
  instance_type = "t2.micro"
  user_data_base64 = base64encode(local.user_data)
  security_groups = [module.security_group.this_security_group_id]
  # key_name = "id_rsa.pub"
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  depends_on = [module.elb, module.security_group, aws_launch_configuration.launch_configuration]

  name = "webserver_autoscalling"

  # Launch configuration
  launch_configuration = aws_launch_configuration.launch_configuration.name # Use the existing launch configuration
  create_lc = false # disables creation of launch configuration

  security_groups = [module.security_group.this_security_group_id]
  load_balancers  = [module.elb.this_elb_id]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "webserver"
  vpc_zone_identifier       = data.aws_subnet_ids.all.ids
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 5
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
}