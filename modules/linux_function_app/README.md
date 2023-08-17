# Linux Function App

A module to create a linux function app and service plan.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.5.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.67.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.67.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_function_app.linux_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/linux_function_app) | resource |
| [azurerm_service_plan.linux_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/service_plan) | resource |
| [azurerm_storage_account.cognitive_service_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_account) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Linux Function App should exist. <br>Changing this forces a new Linux Function App to be created. | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name which should be used for this Linux Function App. <br>Changing this forces a new Linux Function App to be created. <br>Limit the function name to 32 characters to avoid naming collisions. | `string` | n/a | yes |
| <a name="input_personal_ip_address"></a> [personal\_ip\_address](#input\_personal\_ip\_address) | Add your client IP address to the networking to allow<br>access. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Linux Function App should exist. <br>Changing this forces a new Linux Function App to be created. | `string` | n/a | yes |
| <a name="input_service_plan"></a> [service\_plan](#input\_service\_plan) | The pricing tier for hosting the resource. | `string` | `"Y1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_function_app_id"></a> [linux\_function\_app\_id](#output\_linux\_function\_app\_id) | The ID of the Linux Function App. |
<!-- END_TF_DOCS -->