# Video Indexers

A module to create Azure AI Video Indexer. This also creates a storage account and a [soon to be retired media service account](https://learn.microsoft.com/en-us/azure/media-services/latest/azure-media-services-retirement).

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
| [azurerm_media_services_account.media_services](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/media_services_account) | resource |
| [azurerm_resource_group_template_deployment.video_indexer](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/resource_group_template_deployment) | resource |
| [azurerm_role_assignment.video_indexer_media_services_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.media_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_account) | resource |
| [azurerm_user_assigned_identity.video_indexer_user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/user_assigned_identity) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. <br>Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Media Services Account. <br>Only lowercase Alphanumeric characters allowed. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_personal_ip_address"></a> [personal\_ip\_address](#input\_personal\_ip\_address) | Add your client IP address to the networking to allow<br>access. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Media Services Account. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_media_services_account_id"></a> [media\_services\_account\_id](#output\_media\_services\_account\_id) | The ID of the Media Services Account. |
<!-- END_TF_DOCS -->
