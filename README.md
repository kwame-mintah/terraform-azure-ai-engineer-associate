# Terraform Azure Ai Engineer Associate

The main purpose of this repository is to terraform all the resources needed for [Exam AI-102: Designing and Implementing a Microsoft Azure AI Solution - Certification](https://learn.microsoft.com/en-us/certifications/exams/ai-102/?ns-enrollment-type=Collection&ns-enrollment-id=63rjhrqoe512d3).

The end goal is to be easily deploy all the resources needed for the [self-paced learning](https://learn.microsoft.com/en-us/users/kwame-mintah/collections/63rjhrqoe512d3) modules.

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

> **IMPORTANT**
>
> Please note that `.tfstate` files are stored locally on your machine on first apply, an Azure Storage account is created as part of the Terraform. 
> However you will be required to migrate to it after the tfstate storage account has been created. Please see comments in `backend.tf` or any of the environment `terragrunt.hcl`.
>

## Cost

A majority of the resources created will have either the 'Standard' or 'Free' tier used, however this does not mean that it will be cheap. Please be mindful of the cost for each tier,
for example the Azure Container Instance is always running and you will be charged for it's up-time during the month. [Infracost](https://www.infracost.io/) has been used to help indicate how much it will cost
you to have all these resources created.

<details>
<summary>Predicted Infracost as of 14/08/2023</summary>

  ```markdown
  Name                                                                              Monthly Qty  Unit                      Monthly Cost

  azurerm_key_vault_key.tfstate_key_vault_key
  ├─ Secrets operations                                                      Monthly cost depends on usage: $0.03 per 10K transactions
  ├─ Storage key rotations                                                   Monthly cost depends on usage: $1.00 per renewals
  └─ Software-protected keys                                                 Monthly cost depends on usage: $0.03 per 10K transactions

  azurerm_log_analytics_workspace.tfstate_analytics_workspace
  ├─ Log data ingestion                                                      Monthly cost depends on usage: $2.99 per GB
  ├─ Log data export                                                         Monthly cost depends on usage: $0.13 per GB
  ├─ Basic log data ingestion                                                Monthly cost depends on usage: $0.65 per GB
  ├─ Basic log search queries                                                Monthly cost depends on usage: $0.0065 per GB searched
  ├─ Archive data                                                            Monthly cost depends on usage: $0.026 per GB
  ├─ Archive data restored                                                   Monthly cost depends on usage: $0.13 per GB
  └─ Archive data searched                                                   Monthly cost depends on usage: $0.0065 per GB

  azurerm_storage_account.tfstate
  ├─ Capacity                                                                Monthly cost depends on usage: $0.0392 per GB
  ├─ Write operations                                                        Monthly cost depends on usage: $0.11 per 10k operations
  ├─ List and create container operations                                    Monthly cost depends on usage: $0.11 per 10k operations
  ├─ Read operations                                                         Monthly cost depends on usage: $0.0043 per 10k operations
  ├─ All other operations                                                    Monthly cost depends on usage: $0.0043 per 10k operations
  └─ Blob index                                                              Monthly cost depends on usage: $0.075 per 10k tags

  module.media_services_video_indexer.azurerm_storage_account.media_storage
  ├─ Capacity                                                                Monthly cost depends on usage: $0.0392 per GB
  ├─ Write operations                                                        Monthly cost depends on usage: $0.11 per 10k operations
  ├─ List and create container operations                                    Monthly cost depends on usage: $0.11 per 10k operations
  ├─ Read operations                                                         Monthly cost depends on usage: $0.0043 per 10k operations
  ├─ All other operations                                                    Monthly cost depends on usage: $0.0043 per 10k operations
  └─ Blob index                                                              Monthly cost depends on usage: $0.075 per 10k tags

  OVERALL TOTAL                                                                                                                   $0.00
  ──────────────────────────────────
  41 cloud resources were detected:
  ∙ 5 were estimated, all of which include usage-based costs, see https://infracost.io/usage-file
  ∙ 29 were free:
    ∙ 10 x azurerm_key_vault_secret
    ∙ 6 x azurerm_key_vault
    ∙ 5 x azurerm_monitor_activity_log_alert
    ∙ 1 x azurerm_key_vault_access_policy
    ∙ 1 x azurerm_log_analytics_storage_insights
    ∙ 1 x azurerm_resource_group
    ∙ 1 x azurerm_role_assignment
    ∙ 1 x azurerm_search_service
    ∙ 1 x azurerm_storage_account_customer_managed_key
    ∙ 1 x azurerm_storage_container
    ∙ 1 x azurerm_user_assigned_identity
  ∙ 7 are not supported yet, see https://infracost.io/requested-resources:
    ∙ 5 x azurerm_cognitive_account
    ∙ 1 x azurerm_media_services_account
    ∙ 1 x azurerm_resource_group_template_deployment
  ```

</details>

## Pre-Commit hooks

Git hook scripts are very helpful for identifying simple issues before pushing any changes. Hooks will run on every commit automatically pointing out issues in the code e.g. trailing whitespace.

To help with the maintenance of these hooks, [pre-commit](https://pre-commit.com/) is used, along with [pre-commit-hooks](https://pre-commit.com/#install).

Please following [these instructions](https://pre-commit.com/#install) to install `pre-commit` locally and ensure that you have run `pre-commit install` to install the hooks for this project.

Additionally, once installed, the hooks can be updated to the latest available version with `pre-commit autoupdate`.

## Documentation Generation

Code formatting and documentation for `variables` and `outputs` is generated using [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/releases) hooks that in turn uses [terraform-docs](https://github.com/terraform-docs/terraform-docs) that will insert/update documentation. The following markers have been added to the `README.md`:
```
<!-- {BEGIN|END}_TF_DOCS --->
```

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cognitive_services"></a> [cognitive\_services](#module\_cognitive\_services) | ./modules/cognitive_services | n/a |
| <a name="module_cognitive_services_container_language"></a> [cognitive\_services\_container\_language](#module\_cognitive\_services\_container\_language) | ./modules/container_instances | n/a |
| <a name="module_custom_question_answer_service"></a> [custom\_question\_answer\_service](#module\_custom\_question\_answer\_service) | ./modules/cognitive_services | n/a |
| <a name="module_custom_vision_service_prediction"></a> [custom\_vision\_service\_prediction](#module\_custom\_vision\_service\_prediction) | ./modules/cognitive_services | n/a |
| <a name="module_custom_vision_service_training"></a> [custom\_vision\_service\_training](#module\_custom\_vision\_service\_training) | ./modules/cognitive_services | n/a |
| <a name="module_form_recognizer"></a> [form\_recognizer](#module\_form\_recognizer) | ./modules/cognitive_services | n/a |
| <a name="module_language_service"></a> [language\_service](#module\_language\_service) | ./modules/cognitive_services | n/a |
| <a name="module_video_indexer_media_services"></a> [video\_indexer\_media\_services](#module\_video\_indexer\_media\_services) | ./modules/video_indexers | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.tfstate_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.tfstate_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.tfstate_key_vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/key_vault_key) | resource |
| [azurerm_log_analytics_storage_insights.tfstate_analytics_storage_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/log_analytics_storage_insights) | resource |
| [azurerm_log_analytics_workspace.tfstate_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.tfstate_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.environment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/resource_group) | resource |
| [azurerm_search_service.cognitive_search_service](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/search_service) | resource |
| [azurerm_search_service.qna_search_service](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/search_service) | resource |
| [azurerm_storage_account.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.tfstate_cmk](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_account_customer_managed_key) | resource |
| [azurerm_storage_container.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/resources/storage_container) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.67.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | The Client ID which should be used. This can also be sourced <br>from the ARM\_CLIENT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | The Client Secret which should be used. This can also be sourced <br>from the ARM\_CLIENT\_SECRET Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | The Subscription ID which should be used. This can also be sourced <br>from the ARM\_SUBSCRIPTION\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_tenant_id"></a> [arm\_tenant\_id](#input\_arm\_tenant\_id) | The Tenant ID which should be used. This can also be sourced <br>from the ARM\_TENANT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_cloud_enviornment"></a> [cloud\_enviornment](#input\_cloud\_enviornment) | The Cloud Environment which should be used. Possible values are public,<br>`usgovernment`, `german`, and `china`. Defaults to `public`. This can also be <br>sourced from the ARM\_ENVIRONMENT Environment Variable. | `string` | `"public"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Resource Group should exist. <br>Changing this forces a new Resource Group to be created. | `string` | `"West Europe"` | no |
| <a name="input_personal_ip_address"></a> [personal\_ip\_address](#input\_personal\_ip\_address) | Add your client IP address to the networking to allow access. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_service_endpoint"></a> [cognitive\_service\_endpoint](#output\_cognitive\_service\_endpoint) | The endpoint used to connect to the Cognitive Service <br>Account. |
| <a name="output_cognitive_service_key_vault_name"></a> [cognitive\_service\_key\_vault\_name](#output\_cognitive\_service\_key\_vault\_name) | The name of the key vault created to contain cognitive service<br>secrets. |
| <a name="output_cognitive_service_primary_access_key"></a> [cognitive\_service\_primary\_access\_key](#output\_cognitive\_service\_primary\_access\_key) | The primary access key which can be used to connect to <br>the Cognitive Service Account. |
| <a name="output_cognitive_service_secondary_access_key"></a> [cognitive\_service\_secondary\_access\_key](#output\_cognitive\_service\_secondary\_access\_key) | The secondary access key which can be used to connect <br>to the Cognitive Service Account. |
| <a name="output_cognitive_services_container_language_fdqn"></a> [cognitive\_services\_container\_language\_fdqn](#output\_cognitive\_services\_container\_language\_fdqn) | The FDQN to connect to the container instance. |
| <a name="output_custom_vision_service_prediction_endpoint"></a> [custom\_vision\_service\_prediction\_endpoint](#output\_custom\_vision\_service\_prediction\_endpoint) | The endpoint used to connect to the custom vision <br>prediction service Account. |
| <a name="output_custom_vision_service_prediction_key_vault_name"></a> [custom\_vision\_service\_prediction\_key\_vault\_name](#output\_custom\_vision\_service\_prediction\_key\_vault\_name) | The name of the key vault created to contain custom vision<br>secrets. |
| <a name="output_custom_vision_service_prediction_primary_access_key"></a> [custom\_vision\_service\_prediction\_primary\_access\_key](#output\_custom\_vision\_service\_prediction\_primary\_access\_key) | The primary access key which can be used to connect to <br>the Cognitive Service Account. |
| <a name="output_custom_vision_service_prediction_secondary_access_key"></a> [custom\_vision\_service\_prediction\_secondary\_access\_key](#output\_custom\_vision\_service\_prediction\_secondary\_access\_key) | The secondary access key which can be used to connect <br>to the Cognitive Service Account. |
| <a name="output_custom_vision_service_training_endpoint"></a> [custom\_vision\_service\_training\_endpoint](#output\_custom\_vision\_service\_training\_endpoint) | The endpoint used to connect to the custom vision <br>training service Account. |
| <a name="output_custom_vision_service_training_key_vault_name"></a> [custom\_vision\_service\_training\_key\_vault\_name](#output\_custom\_vision\_service\_training\_key\_vault\_name) | The name of the key vault created to contain custom vision<br>secrets. |
| <a name="output_custom_vision_service_training_primary_access_key"></a> [custom\_vision\_service\_training\_primary\_access\_key](#output\_custom\_vision\_service\_training\_primary\_access\_key) | The primary access key which can be used to connect to <br>the Cognitive Service Account. |
| <a name="output_custom_vision_service_training_secondary_access_key"></a> [custom\_vision\_service\_training\_secondary\_access\_key](#output\_custom\_vision\_service\_training\_secondary\_access\_key) | The secondary access key which can be used to connect <br>to the Cognitive Service Account. |
| <a name="output_form_recognizer_endpoint"></a> [form\_recognizer\_endpoint](#output\_form\_recognizer\_endpoint) | The endpoint used to connect to the form recognizer<br> Account. |
| <a name="output_form_recognizer_key_vault_name"></a> [form\_recognizer\_key\_vault\_name](#output\_form\_recognizer\_key\_vault\_name) | The name of the key vault created to contain form recognizer<br>secrets. |
| <a name="output_form_recognizer_primary_access_key"></a> [form\_recognizer\_primary\_access\_key](#output\_form\_recognizer\_primary\_access\_key) | The primary access key which can be used to connect to <br>the Cognitive Service Account. |
| <a name="output_form_recognizer_secondary_access_key"></a> [form\_recognizer\_secondary\_access\_key](#output\_form\_recognizer\_secondary\_access\_key) | The secondary access key which can be used to connect <br>to the Cognitive Service Account. |
| <a name="output_language_service_endpoint"></a> [language\_service\_endpoint](#output\_language\_service\_endpoint) | The endpoint used to connect to the Language Service <br>Account. |
| <a name="output_language_service_key_vault_name"></a> [language\_service\_key\_vault\_name](#output\_language\_service\_key\_vault\_name) | The name of the key vault created to contain language service<br>secrets. |
| <a name="output_language_service_primary_access_key"></a> [language\_service\_primary\_access\_key](#output\_language\_service\_primary\_access\_key) | The primary access key which can be used to connect to <br>the Language Service Account. |
| <a name="output_language_service_secondary_access_key"></a> [language\_service\_secondary\_access\_key](#output\_language\_service\_secondary\_access\_key) | The secondary access key which can be used to connect <br>to the Language Service Account. |
| <a name="output_service_principal_client_id"></a> [service\_principal\_client\_id](#output\_service\_principal\_client\_id) | The principal being used to apply terraform changes <br>for this subscription. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID used for this subscription. |
| <a name="output_tfstate_resource_group_name"></a> [tfstate\_resource\_group\_name](#output\_tfstate\_resource\_group\_name) | The name of the resource group created for the<br>Terraform tfstate. |
| <a name="output_tfstate_storage_account_key"></a> [tfstate\_storage\_account\_key](#output\_tfstate\_storage\_account\_key) | The storage account key created for the<br>Terraform tfstate. |
| <a name="output_tfstate_storage_account_name"></a> [tfstate\_storage\_account\_name](#output\_tfstate\_storage\_account\_name) | The name of the storage account created for the<br>Terraform tfstate. |
| <a name="output_tfstate_storage_container_name"></a> [tfstate\_storage\_container\_name](#output\_tfstate\_storage\_container\_name) | The name of the storage container created for the<br>Terraform tfstate. |
<!-- END_TF_DOCS -->