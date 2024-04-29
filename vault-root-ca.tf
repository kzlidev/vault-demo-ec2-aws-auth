resource "vault_pki_secret_backend_root_cert" "root_ca" {
  depends_on   = [vault_mount.pki]
  backend      = vault_mount.pki.path
  type         = "internal"
  common_name  = var.common_name
  issuer_name  = "${var.prefix}-org-issuer"
  ttl          = "315360000"
  ou           = "demo-ou"
  organization = "${var.prefix}-org"
}

resource "vault_pki_secret_backend_config_urls" "root_ca" {
  backend              = vault_mount.pki.path
  issuing_certificates = [
    "${var.vault_addr}/v1/pki/ca",
  ]
  crl_distribution_points = [
    "${var.vault_addr}/v1/pki/crl"
  ]
}