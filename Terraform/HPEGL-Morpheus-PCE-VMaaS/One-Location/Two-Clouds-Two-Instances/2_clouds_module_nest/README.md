<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hpegl"></a> [hpegl](#requirement\_hpegl) | = 0.4.14 |
| <a name="requirement_morpheus"></a> [morpheus](#requirement\_morpheus) | >= 0.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hpegl"></a> [hpegl](#provider\_hpegl) | 0.4.14 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance_cloud_1"></a> [instance\_cloud\_1](#module\_instance\_cloud\_1) | ../vmaas_instance | n/a |
| <a name="module_instance_cloud_2"></a> [instance\_cloud\_2](#module\_instance\_cloud\_2) | ../vmaas_instance | n/a |
| <a name="module_morpheus_artefacts_1"></a> [morpheus\_artefacts\_1](#module\_morpheus\_artefacts\_1) | ../morpheus_artefacts | n/a |
| <a name="module_morpheus_artefacts_2"></a> [morpheus\_artefacts\_2](#module\_morpheus\_artefacts\_2) | ../morpheus_artefacts | n/a |

## Resources

| Name | Type |
|------|------|
| [hpegl_vmaas_morpheus_details.morpheus_details](https://registry.terraform.io/providers/HPE/hpegl/0.4.14/docs/data-sources/vmaas_morpheus_details) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_1"></a> [cloud\_1](#input\_cloud\_1) | cloud 1 | `string` | n/a | yes |
| <a name="input_cloud_2"></a> [cloud\_2](#input\_cloud\_2) | cloud 2 | `string` | n/a | yes |
| <a name="input_compute_folder_1"></a> [compute\_folder\_1](#input\_compute\_folder\_1) | computefolder 1 | `string` | n/a | yes |
| <a name="input_compute_folder_2"></a> [compute\_folder\_2](#input\_compute\_folder\_2) | computefolder 2 | `string` | n/a | yes |
| <a name="input_datastore_1"></a> [datastore\_1](#input\_datastore\_1) | datastore 1 | `string` | n/a | yes |
| <a name="input_datastore_2"></a> [datastore\_2](#input\_datastore\_2) | datastore 2 | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | environment | `string` | n/a | yes |
| <a name="input_group_1"></a> [group\_1](#input\_group\_1) | group 1 | `string` | n/a | yes |
| <a name="input_group_2"></a> [group\_2](#input\_group\_2) | group 2 | `string` | n/a | yes |
| <a name="input_image_name_1"></a> [image\_name\_1](#input\_image\_name\_1) | image name 1 | `string` | n/a | yes |
| <a name="input_image_name_2"></a> [image\_name\_2](#input\_image\_name\_2) | image name 2 | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name for the instance | `string` | n/a | yes |
| <a name="input_layout_1"></a> [layout\_1](#input\_layout\_1) | layout 1 | `string` | n/a | yes |
| <a name="input_layout_2"></a> [layout\_2](#input\_layout\_2) | layout 2 | `string` | n/a | yes |
| <a name="input_location_1"></a> [location\_1](#input\_location\_1) | Tenant location 1 | `string` | n/a | yes |
| <a name="input_location_2"></a> [location\_2](#input\_location\_2) | Tenant location 2 | `string` | n/a | yes |
| <a name="input_network_1"></a> [network\_1](#input\_network\_1) | network 1 | `string` | n/a | yes |
| <a name="input_network_2"></a> [network\_2](#input\_network\_2) | network 2 | `string` | n/a | yes |
| <a name="input_resource_pool_1"></a> [resource\_pool\_1](#input\_resource\_pool\_1) | resourcepool 1 | `string` | n/a | yes |
| <a name="input_resource_pool_2"></a> [resource\_pool\_2](#input\_resource\_pool\_2) | resourcepool 2 | `string` | n/a | yes |
| <a name="input_service_plan_1"></a> [service\_plan\_1](#input\_service\_plan\_1) | serviceplan 1 | `string` | n/a | yes |
| <a name="input_service_plan_2"></a> [service\_plan\_2](#input\_service\_plan\_2) | serviceplan 2 | `string` | n/a | yes |
| <a name="input_space"></a> [space](#input\_space) | space | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ids_cloud_1"></a> [instance\_ids\_cloud\_1](#output\_instance\_ids\_cloud\_1) | List of IDs of the instances created for Cloud 1 |
| <a name="output_instance_ids_cloud_2"></a> [instance\_ids\_cloud\_2](#output\_instance\_ids\_cloud\_2) | List of IDs of the instances created for Cloud 2 |
| <a name="output_instance_layout_id_cloud_1"></a> [instance\_layout\_id\_cloud\_1](#output\_instance\_layout\_id\_cloud\_1) | The ID of the instance layout created for Cloud 1 |
| <a name="output_instance_layout_id_cloud_2"></a> [instance\_layout\_id\_cloud\_2](#output\_instance\_layout\_id\_cloud\_2) | The ID of the instance layout created for Cloud 2 |
| <a name="output_instance_layout_name_cloud_1"></a> [instance\_layout\_name\_cloud\_1](#output\_instance\_layout\_name\_cloud\_1) | The name of the instance layout created for Cloud 1 |
| <a name="output_instance_layout_name_cloud_2"></a> [instance\_layout\_name\_cloud\_2](#output\_instance\_layout\_name\_cloud\_2) | The name of the instance layout created for Cloud 2 |
| <a name="output_instance_names_cloud_1"></a> [instance\_names\_cloud\_1](#output\_instance\_names\_cloud\_1) | List of names of the instances created for Cloud 1 |
| <a name="output_instance_names_cloud_2"></a> [instance\_names\_cloud\_2](#output\_instance\_names\_cloud\_2) | List of names of the instances created for Cloud 2 |
| <a name="output_node_type_id_cloud_1"></a> [node\_type\_id\_cloud\_1](#output\_node\_type\_id\_cloud\_1) | The ID of the node type created for Cloud 1 |
| <a name="output_node_type_id_cloud_2"></a> [node\_type\_id\_cloud\_2](#output\_node\_type\_id\_cloud\_2) | The ID of the node type created for Cloud 2 |
| <a name="output_node_type_name_cloud_1"></a> [node\_type\_name\_cloud\_1](#output\_node\_type\_name\_cloud\_1) | The name of the node type created for Cloud 1 |
| <a name="output_node_type_name_cloud_2"></a> [node\_type\_name\_cloud\_2](#output\_node\_type\_name\_cloud\_2) | The name of the node type created for Cloud 2 |
<!-- END_TF_DOCS -->