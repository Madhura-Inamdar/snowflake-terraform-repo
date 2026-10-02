resource "snowflake_procedure_sql" "mf_copy_into_sp" {
  database    = snowflake_database.tf_db.name
  schema      = snowflake_schema.tf_test_schema.name
  name        = "tf_mf_copy_into_sp"
  return_type = "VARCHAR(100)"

  procedure_definition = <<EOT
BEGIN
    COPY INTO ${snowflake_table.tf_test_table.fully_qualified_name}
    FROM @${snowflake_stage_internal.test_internal_stage.fully_qualified_name}
    FILE_FORMAT = (FORMAT_NAME = '${snowflake_file_format_csv.tf_mf_file_format.fully_qualified_name}');

    RETURN 'Successfully copied';
END;
EOT
}

resource "snowflake_execute" "tf_mf_call_sp" {
  provider = snowflake.with_warehouse

  execute = "CALL ${snowflake_procedure_sql.mf_copy_into_sp.fully_qualified_name}"
  revert  = "SELECT 1;"

  depends_on = [
    snowflake_warehouse.tf_warehouse,
    null_resource.test_upload_csv,
    snowflake_procedure_sql.mf_copy_into_sp
  ]
}