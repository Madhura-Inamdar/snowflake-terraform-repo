provider "snowflake" {
  organization_name = local.organization_name
  account_name      = local.account_name
  user              = local.user
  role              = local.role
  authenticator     = local.authenticator
  private_key       = file(local.private_key_path)

  preview_features_enabled = local.preview_features_enabled
}

provider "snowflake" {
  alias             = "with_warehouse"
  organization_name = local.organization_name
  account_name      = local.account_name
  user              = local.user
  role              = local.role
  authenticator     = local.authenticator
  private_key       = file(local.private_key_path)

  warehouse = snowflake_warehouse.tf_warehouse.name

  preview_features_enabled = local.preview_features_enabled
}

locals {
  organization_name          = "oasfber"
  account_name               = "pib07727"
  private_key_path           = "~/.ssh/snowflake_tf_snow_key2.p8"
  mutual_funds_file_location = "${path.module}/data/mutual_funds_data.csv"
  role                       = "TF_ROLE"
  user                       = "TERRAFORM_SVC"
  authenticator              = "SNOWFLAKE_JWT"

  preview_features_enabled = [
    "snowflake_table_resource",
    "snowflake_procedure_sql_resource",
    "snowflake_user_password_policy_attachment_resource"
  ]
}