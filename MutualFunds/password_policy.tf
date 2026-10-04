resource "snowflake_password_policy" "tf_test_password_policy" {
  database             = snowflake_database.tf_db.name
  schema               = snowflake_schema.tf_test_schema.name
  name                 = "tf_test_password_policy"
  min_length           = 8
  max_length           = 15
  min_upper_case_chars = 1
  min_lower_case_chars = 1
  min_numeric_chars    = 1
  min_special_chars    = 1
  max_retries          = 5
  history              = 5
  comment              = "My password policy"
}