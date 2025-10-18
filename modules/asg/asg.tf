# create a launch template
# terraform aws launch template
resource "aws_launch_template" "webserver_launch_template" {
  name          = var.asg_launch_template_name
  image_id      = var.ec2_ami_id
  instance_type = var.instance_type
  key_name      = var.ec2_key_pair
  description   = "launch template for asg"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = var.web_server_sg_id
  

}

# create auto scaling group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "auto_scaling_group" {
  vpc_zone_identifier = var.asg_subnet_id
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  name                = "dev-asg"
  health_check_type   = "ELB"

  launch_template {
    name    = aws_launch_template.webserver_launch_template.name
    version = "$Latest"


  }

  tag {
    key                 = "Name"
    value               = "ASG Web Server"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes      = [target_group_arns]
  }
}

# attach auto scaling group to alb target group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.id
  lb_target_group_arn    = var.alb_target_group_arn
}

# create an auto scaling group notification
# terraform aws autoscaling notification
resource "aws_autoscaling_notification" "webserver_asg_notifications" {
  group_names = [aws_autoscaling_group.auto_scaling_group.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = var.sns_topic_arn
}


