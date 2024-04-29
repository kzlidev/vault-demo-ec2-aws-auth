#resource "vault_transform_role" "transform" {
#  path            = vault_mount.transform.path
#  name            = "payments"
#  transformations = ["card-number"]
#}
#
#resource "vault_transform_transformation" "transform" {
#  path          = vault_mount.transform.path
#  name          = "card-number"
#  type          = "fpe" # Format-preserving Encryption
#  template      = "builtin/creditcardnumber"
#  tweak_source  = "internal"
#  # How to tweak the transformation. For Internal vault will generate and use the same for every request
#  allowed_roles = ["payments"]
#}