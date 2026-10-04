resource "snowflake_user" "tf_test_user" {
  name         = "Snowflake User"
  login_name   = var.login_name
  first_name   = var.first_name
  last_name    = var.last_name
  comment      = "User of snowflake."
  password     = var.password
  disabled     = "false"
  display_name = "Snowflake User display name"

  default_warehouse = snowflake_warehouse.tf_warehouse.fully_qualified_name
  default_role      = local.role

  must_change_password = "true"
  disable_mfa          = "false"
}

resource "snowflake_user_password_policy_attachment" "tf_test_ppa" {
  provider = snowflake.with_warehouse

  password_policy_name = snowflake_password_policy.tf_test_password_policy.fully_qualified_name
  user_name            = snowflake_user.tf_test_user.name
}