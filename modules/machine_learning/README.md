# Machine Learning

A module to create a machine learning workspace and compute resources.

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
| [azurerm_application_insights.machine_learning_key_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/application_insights) | resource |
| [azurerm_container_registry.machine_learining_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/container_registry) | resource |
| [azurerm_key_vault.machine_learning_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault) | resource |
| [azurerm_machine_learning_compute_cluster.machine_learning_compute_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/machine_learning_compute_cluster) | resource |
| [azurerm_machine_learning_workspace.machine_learning_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/machine_learning_workspace) | resource |
| [azurerm_storage_account.machine_learning_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.machine_learning_network_rules](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_account_network_rules) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the Machine Learning Workspace should exist. <br>Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Machine Learning Workspace. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_personal_ip_address"></a> [personal\_ip\_address](#input\_personal\_ip\_address) | Add your client IP address to the networking to allow<br>access. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group in which the Machine Learning Workspace should exist. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_machine_learning_workspace_discovery_url"></a> [machine\_learning\_workspace\_discovery\_url](#output\_machine\_learning\_workspace\_discovery\_url) | The url for the discovery service to identify regional endpoints <br>for machine learning experimentation services. |
| <a name="output_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#output\_machine\_learning\_workspace\_id) | The ID of the Machine Learning Workspace. |
| <a name="output_machine_learning_workspace_workspace_id"></a> [machine\_learning\_workspace\_workspace\_id](#output\_machine\_learning\_workspace\_workspace\_id) | The immutable id associated with this workspace. |
<!-- END_TF_DOCS -->