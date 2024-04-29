#resource "vault_database_secret_backend_connection" "postgres" {
#  backend       = vault_mount.db.path
#  name          = "postgres"
#  allowed_roles = ["readonly", "adminuser"]
#  plugin_name   = "postgresql-database-plugin"
#
#  postgresql {
#    username       = module.psql.username
#    password       = module.psql.password
#    connection_url = "postgresql://{{username}}:{{password}}@${module.psql.host}/postgres"
#  }
#}
#
#resource "vault_generic_endpoint" "rotate_initial_db_password" {
#  depends_on     = [vault_database_secret_backend_connection.postgres]
#  path           = "${vault_mount.db.path}/rotate-root/${vault_database_secret_backend_connection.postgres.name}"
#  disable_read   = true
#  disable_delete = true
#
#  data_json = "{}"
#}