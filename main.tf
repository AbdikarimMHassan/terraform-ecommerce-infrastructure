# configure aws provider
provider "aws" {
  region = "us-north-1"
  profile = "Abdikarim"
}
# stores the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "abdikarim98-terraform-remote-state"
    key    = "terraform.tfstate.dev"
    region = "eu-north-1"
    profile = "Abdikarim"
  }
}
