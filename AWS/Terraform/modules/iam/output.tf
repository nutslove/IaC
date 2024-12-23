output "test_policy_id" {
  value = module.test.aws_iam_policy.test_policy.id
}

output "test_policy2_id" {
  value = module.test.aws_iam_policy.test_policy2.id
}