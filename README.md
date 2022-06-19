# Authors

- [Francisco Bernad](https://github.com/FrBernad)
- [Nicolás Rampoldi](https://github.com/NicolasRampoldi)
- [Ignacio Vazquez](https://github.com/igvazquez)
- [Santiago Burgos](https://github.com/santiagoburgos)
# CLOUD COMPUTING - TP3

## Setup
### Terraform

Install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) following official instructions.

### Amazon Web Services

1. Create a new AWS user for terraform with `AdministratorAccess` permissions.
2. Generate and store user access keys inside `$HOME/.aws/credentials`.
3. Create a `Route53` `HostedZone` with the domain to be used.

### 6. Deploy Project

1. Configure variables inside `config.tfvars`:
    - `aws_region`: AWS region to deploy.
    - `aws_authorized_role`: role with permissions to create and modify resources.
    - `base_domain`: application domain or subdomain created in `Route53` `HostedZone` .

2. Run `terraform apply -var-file=config.tfvars` to deploy.
