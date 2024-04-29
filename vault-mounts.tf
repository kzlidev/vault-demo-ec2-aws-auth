resource "vault_mount" "kvv2" {
  path        = "kvv2"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_mount" "db" {
  path        = "${var.prefix}-psql-mount"
  type        = "database"
  description = "Database Secret Engine for Demo"
}

resource "vault_mount" "transform" {
  path = "${var.prefix}-transform"
  type = "transform"
}

resource "vault_mount" "transit" {
  path        = "${var.prefix}-transit"
  type        = "transit"
  description = "This is an example transit secret engine mount"

  options = {
    convergent_encryption = false
  }
}

resource "vault_mount" "pki" {
  path = "${var.prefix}-pki"
  type = "pki"
}