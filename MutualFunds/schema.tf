resource "snowflake_schema" "tf_test_schema" {
  name     = "TF_TEST_SCHEMA"
  database = snowflake_database.tf_db.fully_qualified_name
}
