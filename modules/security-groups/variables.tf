# vpc id declared in a variable.
# placeholder until we call it in the roor where we store the vpc -
# id which we get via outputs.tf in the vpc module
variable "vpc_id" {
    type = string
  
}



# security groups variables

variable "ssh_location" {
    default = "0.0.0.0/0"
    description = "ssh access into the ec2 instances"
    type = string
  
}