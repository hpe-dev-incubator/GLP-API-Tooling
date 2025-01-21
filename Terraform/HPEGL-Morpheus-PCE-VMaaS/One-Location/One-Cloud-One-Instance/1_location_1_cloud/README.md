<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hpegl"></a> [hpegl](#requirement\_hpegl) | >= 0.0.1 |
| <a name="requirement_morpheus"></a> [morpheus](#requirement\_morpheus) | >= 0.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hpegl"></a> [hpegl](#provider\_hpegl) | 0.4.16 |
| <a name="provider_morpheus"></a> [morpheus](#provider\_morpheus) | 0.11.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hpegl_vmaas_instance.sample_vm](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/resources/vmaas_instance) | resource |
| [morpheus_group.tf_example_group](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/group) | resource |
| [morpheus_instance_layout.tf_example_instance_layout](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/instance_layout) | resource |
| [morpheus_instance_type.tf_example_instance_type](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/instance_type) | resource |
| [morpheus_node_type.tf_example_node](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/node_type) | resource |
| [random_integer.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [hpegl_vmaas_cloud_folder.compute_folder](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_cloud_folder) | data source |
| [hpegl_vmaas_datastore.c_3par](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_datastore) | data source |
| [hpegl_vmaas_environment.env](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_environment) | data source |
| [hpegl_vmaas_morpheus_details.morpheus_details](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_morpheus_details) | data source |
| [hpegl_vmaas_network.blue_segment](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_network) | data source |
| [hpegl_vmaas_plan.g1_large](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_plan) | data source |
| [hpegl_vmaas_resource_pool.cl_resource_pool](https://registry.terraform.io/providers/HPE/hpegl/latest/docs/data-sources/vmaas_resource_pool) | data source |
| [morpheus_cloud.cloud](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/data-sources/cloud) | data source |
| [morpheus_virtual_image.example_virtual_image](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/data-sources/virtual_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud"></a> [cloud](#input\_cloud) | cloud | `string` | n/a | yes |
| <a name="input_compute_folder"></a> [compute\_folder](#input\_compute\_folder) | computefolder | `string` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | datastore | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | environment | `string` | n/a | yes |
| <a name="input_group"></a> [group](#input\_group) | group | `string` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | image name | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name for the instance | `string` | n/a | yes |
| <a name="input_layout"></a> [layout](#input\_layout) | layout | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Tenant location | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | network | `string` | n/a | yes |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | resourcepool | `string` | n/a | yes |
| <a name="input_service_plan"></a> [service\_plan](#input\_service\_plan) | serviceplan | `string` | n/a | yes |
| <a name="input_space"></a> [space](#input\_space) | space | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->