# Terraform Azurem Template

The main purpose of this repository is to create a template for [Terraform](https://www.terraform.io/). This project will focus on the [Azurem](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0) provider.

## Development

### Dependencies

- [terraform](https://www.terraform.io/)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [pre-commit](https://pre-commit.com/)
- [terraform-docs](https://terraform-docs.io/) this is required for `terraform_docs` hooks

## Prerequisites

1. Have a [Azure Portal](https://portal.azure.com/) account. 
2. You will need to create a Service Principal with a Client Secret [follow instructions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-in-the-azure-portal).

## Usage

1. Navigate to the environment you would like to deploy,
2. Plan your changes with `terragrunt plan` to see what changes will be made,
3. If you're happy with the changes `terragrunt apply`.

Please note that `.tfstate` files are stored locally on your machine as no backend has been specified. If you would like to properly version control your state files, it is possible to use an S3 bucket to store these files. 
This will ensure anyone else other than you running a plan/apply will always be using the same state file.

## Pre-Commit hooks

Git hook scripts are very helpful for identifying simple issues before pushing any changes. Hooks will run on every commit automatically pointing out issues in the code e.g. trailing whitespace.

To help with the maintenance of these hooks, [pre-commit](https://pre-commit.com/) is used, along with [pre-commit-hooks](https://pre-commit.com/#install).

Please following [these instructions](https://pre-commit.com/#install) to install `pre-commit` locally and ensure that you have run `pre-commit install` to install the hooks for this project.

Additionally, once installed, the hooks can be updated to the latest available version with `pre-commit autoupdate`.

## Documentation Generation

Code formatting and documentation for `variables` and `outputs` is generated using [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/releases) hooks that in turn uses [terraform-docs](https://github.com/terraform-docs/terraform-docs) that will insert/update documentation. The following markers have been added to the `README.md`:
```
<!-- {BEGINNING|END} OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.4.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.58.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.58.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.tfstate_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_key.tfstate_key_vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault_key) | resource |
| [azurerm_log_analytics_storage_insights.tfstate_analytics_storage_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/log_analytics_storage_insights) | resource |
| [azurerm_log_analytics_workspace.tfstate_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.environment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.tfstate_cmk](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/storage_account_customer_managed_key) | resource |
| [azurerm_storage_container.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/storage_container) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | The Client ID which should be used. This can also be sourced <br>from the ARM\_CLIENT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | The Client Secret which should be used. This can also be sourced <br>from the ARM\_CLIENT\_SECRET Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | The Subscription ID which should be used. This can also be sourced <br>from the ARM\_SUBSCRIPTION\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_tenant_id"></a> [arm\_tenant\_id](#input\_arm\_tenant\_id) | The Tenant ID which should be used. This can also be sourced <br>from the ARM\_TENANT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_cloud_enviornment"></a> [cloud\_enviornment](#input\_cloud\_enviornment) | The Cloud Environment which should be used. Possible values are public,<br>`usgovernment`, `german`, and `china`. Defaults to `public`. This can also be <br>sourced from the ARM\_ENVIRONMENT Environment Variable. | `string` | `"public"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Resource Group should exist. <br>Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_principal_client_id"></a> [service\_principal\_client\_id](#output\_service\_principal\_client\_id) | The principal being used to apply terraform changes <br>for this subscription. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID used for this subscription. |
| <a name="output_tfstate_resource_group_name"></a> [tfstate\_resource\_group\_name](#output\_tfstate\_resource\_group\_name) | The name of the resource group created for the<br>Terraform tfstate. |
| <a name="output_tfstate_storage_account_key"></a> [tfstate\_storage\_account\_key](#output\_tfstate\_storage\_account\_key) | The name of the storage account created for the<br>Terraform tfstate. |
| <a name="output_tfstate_storage_account_name"></a> [tfstate\_storage\_account\_name](#output\_tfstate\_storage\_account\_name) | The name of the storage account created for the<br>Terraform tfstate. |
| <a name="output_tfstate_storage_container_name"></a> [tfstate\_storage\_container\_name](#output\_tfstate\_storage\_container\_name) | The name of the storage container created for the<br>Terraform tfstate. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
