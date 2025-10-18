variable "asg_launch_template_name" {
    type = string
    default = "dev-launch-template"
    description = "name of the launch template"
}

variable "ec2_ami_id" {
    type = string
    default = "ami-09ff4761de2faa6e6"
    description = "ami of the web server ec2"


}

variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "ec2 instance type"
}

variable "ec2_key_pair" {
  type = string
  default = "ec2-key"
  description = "key pair for my ec2"
}

variable "web_server_sg_id" {
    type = list(string)
    description = "web server sg passed to the asg from sg module"
  
}


variable "asg_subnet_id" {
    type = list(string)
  
}

variable "alb_target_group_arn" {
    type = string
  
}

variable "sns_topic_arn" {
    type = string
  
}
