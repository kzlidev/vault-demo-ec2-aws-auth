resource "vault_kv_secret_v2" "app_a_secret" {
  mount               = vault_mount.kvv2.path
  name                = "${var.app_a_prefix}-secret"
  cas                 = 1
  delete_all_versions = true
  data_json           = jsonencode(
    {
      secret = "appASecret"
      version = 1
    }
  )
}

resource "vault_kv_secret_v2" "app_b_secret" {
  mount               = vault_mount.kvv2.path
  name                = "${var.app_b_prefix}-secret"
  cas                 = 1
  delete_all_versions = true
  data_json           = jsonencode(
    {
      secret = "appBSecret"
      version = 1
    }
  )
}
