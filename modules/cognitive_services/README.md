# Cognitive Services

A module to create various cognitive services.

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
| [azurerm_cognitive_account.cognitive_services_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/cognitive_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kind"></a> [kind](#input\_kind) | Specifies the type of Cognitive Service Account that should be created. <br>Possible values are `Academic`, `AnomalyDetector`, `Bing.Autosuggest`, <br>`Bing.Autosuggest.v7`, `Bing.CustomSearch`, `Bing.Search`, `Bing.Search.v7`, <br>`Bing.Speech`, `Bing.SpellCheck`, `Bing.SpellCheck.v7`, `CognitiveServices`, <br>`ComputerVision`, `ContentModerator`, `CustomSpeech`, `CustomVision.Prediction`, <br>`CustomVision.Training`, `Emotion`, `Face`, `FormRecognizer`, `ImmersiveReader`, <br>`LUIS`, `LUIS.Authoring`, `MetricsAdvisor`, `OpenAI`, `Personalizer`, `QnAMaker`, <br>`Recommendations`, `SpeakerRecognition`, `Speech`, `SpeechServices`, `SpeechTranslation`, <br>`TextAnalytics`, `TextTranslation` and `WebLM`. <br>Changing this forces a new resource to be created. | `string` | `"CognitiveServices"` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. <br>Changing this forces a new resource to be created. | `string` | `"West Europe"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Cognitive Service Account. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Cognitive Service Account is created. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this Cognitive Service Account. <br>Possible values are `F0`, `F1`, `S0`, `S`, `S1`, `S2`, `S3`, <br>`S4`, `S5`, `S6`, `P0`, `P1`, `P2`, `E0` and `DC0` | `string` | `"S0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_services_endpoint"></a> [cognitive\_services\_endpoint](#output\_cognitive\_services\_endpoint) | The endpoint used to connect to the Cognitive Service Account. |
| <a name="output_cognitive_services_primary_access_key"></a> [cognitive\_services\_primary\_access\_key](#output\_cognitive\_services\_primary\_access\_key) | A primary access key which can be used to connect to the Cognitive Service Account. |
| <a name="output_cognitive_services_secondary_access_key"></a> [cognitive\_services\_secondary\_access\_key](#output\_cognitive\_services\_secondary\_access\_key) | The secondary access key which can be used to connect to the Cognitive Service Account. |