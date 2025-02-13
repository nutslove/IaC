# output "test_policy_id" {
#   value = module.iam.test_policy_id
# }

# output "test_policy2_id" {
#   value = module.iam.test_policy2_id
# }

data "aws_subnet" "private-subnet-0-ap-northeast-1a" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-0-ap-northeast-1a"]
  }
}

data "aws_subnet" "private-subnet-1-ap-northeast-1c" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-1-ap-northeast-1c"]
  }
}