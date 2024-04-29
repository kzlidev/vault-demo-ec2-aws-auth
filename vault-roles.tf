resource "vault_aws_auth_backend_role" "app_a_aws_auth_role" {
  backend                  = vault_auth_backend.aws.path
  role                     = aws_iam_role.app_a_role.name
  bound_iam_principal_arns = [aws_iam_role.app_a_role.arn]
  auth_type                = "iam"

  token_policies           = [vault_policy.app_a_team_policy.name, vault_policy.app_a_cert_policy.name]

  # This does introduce a limitation; the ARN you reference for bound_iam_principal_arn must be in the form
  # you've given it, because the setting instructs Vault not to resolve ARNs into unique IDs and so it can only
  # pattern match between the ARNs given to it. Vault still properly validates the identity of the role and it's
  # still a secure option, just more restrictive in how you can configure it.
  # Error: unable to resolve ARN "arn:aws:iam::xxxxxxx:role/app-a-role" to internal ID
  resolve_aws_unique_ids = false
}

resource "vault_aws_auth_backend_role" "app_b_aws_auth_role" {
  backend                  = vault_auth_backend.aws.path
  role                     = aws_iam_role.app_b_role.name
  bound_iam_principal_arns = [aws_iam_role.app_b_role.arn]
  auth_type                = "iam"
  token_policies           = [vault_policy.app_b_team_policy.name]

  # This does introduce a limitation; the ARN you reference for bound_iam_principal_arn must be in the form
  # you've given it, because the setting instructs Vault not to resolve ARNs into unique IDs and so it can only
  # pattern match between the ARNs given to it. Vault still properly validates the identity of the role and it's
  # still a secure option, just more restrictive in how you can configure it.
  resolve_aws_unique_ids = false
}

#resource "vault_database_secret_backend_role" "readonly_role" {
#  depends_on          = [module.psql]
#  backend             = vault_mount.db.path
#  name                = "readonly"
#  db_name             = vault_database_secret_backend_connection.postgres.name
#  creation_statements = [
#    # Assumption here is the role "readonly" is already created in the database
#    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;",
#    "GRANT readonly TO \"{{name}}\";"
#  ]
#}
#
#resource "vault_database_secret_backend_role" "admin_role" {
#  depends_on          = [module.psql]
#  backend             = vault_mount.db.path
#  name                = "adminuser"
#  db_name             = vault_database_secret_backend_connection.postgres.name
#  creation_statements = [
#    # Assumption here is the role "readonly" is already created in the database
#    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;",
#    "GRANT adminuser TO \"{{name}}\";"
#  ]
#}

resource "vault_pki_secret_backend_role" "role" {
  backend          = vault_mount.pki.path
  name             = "demo-likz-web-pki"
  ttl              = 3600
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = [var.common_name, "demo.${var.common_name}"]
  allow_subdomains = true
}