# Deploy

## To deploy
```
terraform init
terraform apply --auto-approve
```

# Demo
Once the EC2 has been deployed, connect to them through **instance connect** and set the below Vault environment variables

```shell
export VAULT_ADDR=<VAULT_ADDR>
export VAULT_NAMESPACE=admin
```

Once done, we can login to Vault using the CLI

```shell
vault login -method=aws
```

Render certificates

```shell
vault agent -config=vault-agent.hcl -exit-after-auth=true
```

Lookup token
```shell
vault token lookup
```

Get secrets from KV
```shell
vault kv get -mount="kvv2" "app-a-secret"
vault kv get -mount="kvv2" "app-b-secret"
```