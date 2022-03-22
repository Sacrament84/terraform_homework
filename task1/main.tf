provider "aws" {
        region = "eu-west-2"
}

data "aws_vpcs" "my_test_vpc" {}

data "aws_subnets" "subnet_id" {}

data "aws_security_groups" "sg_id" {}


output "vpc_id" {
  value = data.aws_vpcs.my_test_vpc.ids
} 

output "subnet_id" {
  value = data.aws_subnets.subnet_id.ids
}

output "sg_id" {
  value = data.aws_security_groups.sg_id.ids
}
