# Container Instances

A module to deploy cognitive service image(s) to an Azure Container Instances (ACI) resource.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.5.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.cognitive_service_container_instance](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/container_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cognitive_service_api_key"></a> [cognitive\_service\_api\_key](#input\_cognitive\_service\_api\_key) | Either key for your cognitive services resource. | `string` | n/a | yes |
| <a name="input_cognitive_service_endpoint"></a> [cognitive\_service\_endpoint](#input\_cognitive\_service\_endpoint) | The endpoint URI for your cognitive services resource. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The container image name. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. <br>Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Container Group. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Cognitive Service Account is created. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_service_instance_fdqn"></a> [cognitive\_service\_instance\_fdqn](#output\_cognitive\_service\_instance\_fdqn) | The FQDN of the container group derived from `dns_name_label`. |
<!-- END_TF_DOCS -->
