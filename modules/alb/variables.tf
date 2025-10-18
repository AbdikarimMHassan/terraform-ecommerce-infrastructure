variable "name" {
    type = string
    default = "dev_alb"
  
}
  
variable "alb_type" {
    type = string
    default = "application"
  
}

variable "alb_sg_id"{
    type = list(string)

}

variable "alb_subnet_ids" {
    type = list(string)
  
}

variable "alb_tg" {
    type = string
    default = "dev-tg"
  
}

variable "alb_target_type" {
    type = string
    default = "instance"
}
  
variable "alb_port" {
    type = number
    default = 80
}

variable "alb_protocol" {
    type = string
    default = "HTTP"
  
}

variable "vpc_id" {
    type = string
}


variable "healthy_threshold" {
    type = number
    default = 5
  
}


variable "interval" {
    type = number
    default = 30
}

variable "matcher" {
    type = string
    default = "200,301,302"
  
}

variable "path" {
    type = string
    default = "/"

}


variable "timeout" {
    type = number
    default = 5

}

variable "unhealthy_threshold" {
    type = number
    default = 2
  
}

variable "port_name" {
    type = string
    default = "traffic-port"

}

variable "listener_redirect_port" {
    type = number
    default = 443
  
}

variable "listener_redirect_protocol" {
    type = string
    default = "HTTPS"

}

variable "listener_forward_port" {
    type = number
    default = 443
  
}

variable "listener_forward_protocol" {
    type = string
    default = "HTTPS"
  
}

variable "ssl_certificate_arn" {
    type = string
    description = "SSL certificate arn"
    default = "arn:aws:acm:eu-north-1:779846800049:certificate/cb39d786-d936-4a27-a7e9-e462aca53b09"
}