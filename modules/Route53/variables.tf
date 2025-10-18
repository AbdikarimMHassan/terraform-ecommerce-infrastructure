variable "domain_name" {
    type = string
    default = "abdikarim-tech.com"
    description = "domain name for the website"
  
}

variable "record_name" {
    type = string
    default = "www"

}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
    type = string
  
}