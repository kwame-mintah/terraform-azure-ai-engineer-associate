# Cognitive Services

A module to create various cognitive services.

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
| [azurerm_cognitive_account.cognitive_services_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/cognitive_account) | resource |
| [azurerm_key_vault.cognitive_services_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.cognitive_services_primary_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.cognitive_services_secondary_access_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_activity_log_alert.cognitive_services_alert](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/monitor_activity_log_alert) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kind"></a> [kind](#input\_kind) | Specifies the type of Cognitive Service Account that should be created. <br>Possible values are `Academic`, `AnomalyDetector`, `Bing.Autosuggest`, <br>`Bing.Autosuggest.v7`, `Bing.CustomSearch`, `Bing.Search`, `Bing.Search.v7`, <br>`Bing.Speech`, `Bing.SpellCheck`, `Bing.SpellCheck.v7`, `CognitiveServices`, <br>`ComputerVision`, `ContentModerator`, `CustomSpeech`, `CustomVision.Prediction`, <br>`CustomVision.Training`, `Emotion`, `Face`, `FormRecognizer`, `ImmersiveReader`, <br>`LUIS`, `LUIS.Authoring`, `MetricsAdvisor`, `OpenAI`, `Personalizer`, `QnAMaker`, <br>`Recommendations`, `SpeakerRecognition`, `Speech`, `SpeechServices`, `SpeechTranslation`, <br>`TextAnalytics`, `TextTranslation` and `WebLM`. <br>Changing this forces a new resource to be created. | `string` | `"CognitiveServices"` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. <br>Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Cognitive Service Account. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_personal_ip_address"></a> [personal\_ip\_address](#input\_personal\_ip\_address) | Add your client IP address to the networking to allow<br>access. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Cognitive Service Account is created. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_search_service_id"></a> [search\_service\_id](#input\_search\_service\_id) | If kind is `TextAnalytics` this specifies the ID of the Search service. | `string` | `null` | no |
| <a name="input_search_service_key"></a> [search\_service\_key](#input\_search\_service\_key) | If kind is `TextAnalytics` this specifies the key of the Search service. | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this Cognitive Service Account. <br>Possible values are `F0`, `F1`, `S0`, `S`, `S1`, `S2`, `S3`, <br>`S4`, `S5`, `S6`, `P0`, `P1`, `P2`, `E0` and `DC0` | `string` | `"S0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_services_endpoint"></a> [cognitive\_services\_endpoint](#output\_cognitive\_services\_endpoint) | The endpoint used to connect to the Cognitive Service Account. |
| <a name="output_cognitive_services_key_vault_name"></a> [cognitive\_services\_key\_vault\_name](#output\_cognitive\_services\_key\_vault\_name) | The name of the key vault created to contain cognitive service<br>secrets. |
| <a name="output_cognitive_services_primary_access_key"></a> [cognitive\_services\_primary\_access\_key](#output\_cognitive\_services\_primary\_access\_key) | A primary access key which can be used to connect to the Cognitive Service Account. |
| <a name="output_cognitive_services_secondary_access_key"></a> [cognitive\_services\_secondary\_access\_key](#output\_cognitive\_services\_secondary\_access\_key) | The secondary access key which can be used to connect to the Cognitive Service Account. |
<!-- END_TF_DOCS -->
