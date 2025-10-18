output "rds_sg_id" {
  value = aws_security_group.database_security_group.id
  description = "expose rds db sg id to others"
}

output "web_server_sg_id" {
    value = aws_security_group.webserver_security_group.id
    description = "private app security group id to others"
}

output "alb_sg_id" {
    value = aws_security_group.alb_security_group.id
    description = "expose alb sg id to others"
  
}

