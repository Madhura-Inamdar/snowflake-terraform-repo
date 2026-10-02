resource "snowflake_stage_internal" "test_internal_stage" {
  name     = "TF_TEST_UPLOAD_STAGE"
  database = snowflake_database.tf_db.name
  schema   = snowflake_schema.tf_test_schema.name
  comment  = "Stage for local CSV file uploads."

  depends_on = [
    snowflake_database.tf_db,
    snowflake_schema.tf_test_schema
  ]
}

resource "null_resource" "test_upload_csv" {
  triggers = {
    file_hash = md5(file(local.mutual_funds_file_location))
  }

  provisioner "local-exec" {
     command = "snow stage copy ${local.mutual_funds_file_location} @${snowflake_stage_internal.test_internal_stage.fully_qualified_name} --overwrite --temporary-connection"

    environment = {
      SNOWFLAKE_ACCOUNT          = "${local.organization_name}-${local.account_name}"
      SNOWFLAKE_USER             = "TERRAFORM_SVC"
      SNOWFLAKE_ROLE             = "SYSADMIN"
      SNOWFLAKE_AUTHENTICATOR    = "SNOWFLAKE_JWT"
      SNOWFLAKE_PRIVATE_KEY_PATH = local.private_key_path
    }
  }

  depends_on = [snowflake_stage_internal.test_internal_stage]
}

resource "snowflake_file_format_csv" "tf_mf_file_format" {
  name        = "tf_mf_file_format"
  database    = snowflake_database.tf_db.name
  schema      = snowflake_schema.tf_test_schema.name
  skip_header = 1

  depends_on = [
    snowflake_database.tf_db,
    snowflake_schema.tf_test_schema
  ]
}