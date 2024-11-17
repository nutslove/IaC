module "test" {
  source = "../../../modules/iam"

  test_iam_user_name = "lee-test-user-from-terraform"
}