output "alb_target_group_arn" {
    value = aws_lb_target_group.alb_target_group.arn
  
}

# dns name / alb resource which will be passed as the dns name in route 53

output "alb_dns_name" {
    value = aws_lb.application_load_balancer.dns_name
}

output "alb_zone_id" {
    value = aws_lb.application_load_balancer.zone_id
  
}