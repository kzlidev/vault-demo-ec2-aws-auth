resource "vault_policy" "app_a_team_policy" {
  name = "${var.app_a_prefix}-team"

  policy = <<EOT
path "${vault_kv_secret_v2.app_a_secret.path}" {
  capabilities = [ "read" ]
}
EOT
}

resource "vault_policy" "app_b_team_policy" {
  name = "${var.app_b_prefix}-team"

  policy = <<EOT
path "${vault_kv_secret_v2.app_b_secret.path}" {
  capabilities = [ "read" ]
}
EOT
}

resource "vault_policy" "app_a_cert_policy" {
  name = "${var.app_a_prefix}-cert-policy"

  policy = <<EOT
path "likz-pki/*" {
  capabilities = ["read","create","update"]
}
EOT
}