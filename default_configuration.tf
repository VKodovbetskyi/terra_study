terraform {
  backend "s3" {
    bucket = "terra-bucke"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
  }
}
# Let's Ireland will be our default config region.
# We create only standalone ebs volume here.

/*
Regions reference:
eu-west-1       - Ireland
eu-central-1    - Frankfurt
eu-north-1      - Stockholm
*/

variable "regions" {
  description = "A list of regions we use"
  type        = list
  default     = ["eu-west-1", "eu-central-1", "eu-north-1"]
}

variable "region_aliases" {
  description = "A list of region aliases (keynames have the same values)"
  type        = list
  default     = ["ireland", "frankfurt", "stockholm"]
}

variable "instance_types" {
  description = "A list of instance types we use in our infrastructure"
  type        = list
  default     = ["t2.micro", "t3.micro"]
}

variable "amis" {
  description = "Map of amis due to region"
  type        = map
  default = {
    "eu-central-1" = "ami-0df0e7600ad0913a9"
    "eu-north-1"   = "ami-074a0e4318181e9d9"
  }
}

provider "aws" {
  region = var.regions[0]
}

# resource "aws_ebs_volume" "example" {
#   availability_zone = "eu-west-1a"
#   size              = 10
# }
