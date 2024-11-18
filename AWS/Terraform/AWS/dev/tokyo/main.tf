module "test" {
  source = "../../../modules/iam"

  test_iam_user_name = "lee-test-user-from-terraform"
  default_policy_arn = "arn:aws:iam::299413808364:policy/goa-sec_protection"
}