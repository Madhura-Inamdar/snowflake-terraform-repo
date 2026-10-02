resource "snowflake_database" "tf_db" {
  name         = "TF_TEST_DB"
  is_transient = false
}