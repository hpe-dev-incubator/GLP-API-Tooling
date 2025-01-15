<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hpegl"></a> [hpegl](#provider\_hpegl) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hpegl_vmaas_instance.sample_vm](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/resources/vmaas_instance) | resource |
| [random_integer.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [hpegl_vmaas_cloud_folder.compute_folder](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_cloud_folder) | data source |
| [hpegl_vmaas_datastore.c_3par](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_datastore) | data source |
| [hpegl_vmaas_environment.env](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_environment) | data source |
| [hpegl_vmaas_network.blue_segment](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_network) | data source |
| [hpegl_vmaas_plan.g1_large](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_plan) | data source |
| [hpegl_vmaas_resource_pool.cl_resource_pool](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_resource_pool) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | morpheus cloud id, same name as cloud | `string` | n/a | yes |
| <a name="input_compute_folder"></a> [compute\_folder](#input\_compute\_folder) | computefolder | `string` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | datastore | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | environment | `string` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | group id | `string` | n/a | yes |
| <a name="input_instance_layout_id"></a> [instance\_layout\_id](#input\_instance\_layout\_id) | instance layout id | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name for the instance | `string` | n/a | yes |
| <a name="input_instance_type_code"></a> [instance\_type\_code](#input\_instance\_type\_code) | morpheus instance type code | `string` | n/a | yes |
| <a name="input_layout"></a> [layout](#input\_layout) | layout | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | network | `string` | n/a | yes |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | resourcepool | `string` | n/a | yes |
| <a name="input_service_plan"></a> [service\_plan](#input\_service\_plan) | serviceplan | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | List of IDs of the instances created |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | List of names of the instances created |
<!-- END_TF_DOCS -->