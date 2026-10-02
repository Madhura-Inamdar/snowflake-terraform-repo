resource "snowflake_table" "tf_test_table" {
  database = snowflake_database.tf_db.name
  schema   = snowflake_schema.tf_test_schema.name
  name     = "tf_test_table"
  comment  = "A table."

  column {
    name = "Fund Name"
    type = "VARCHAR"
  }

  column {
    name = "Asset Category"
    type = "VARCHAR"
  }

  column {
    name = "Risk Level"
    type = "VARCHAR"
  }

  column {
    name = "Expense Ratio (Direct)"
    type = "VARCHAR"
  }

  column {
    name = "3-Year CAGR"
    type = "VARCHAR"
  }

  column {
    name = "AUM (₹ Cr)"
    type = "NUMBER"
  }
}