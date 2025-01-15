<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_morpheus"></a> [morpheus](#provider\_morpheus) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [morpheus_group.tf_example_group](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/group) | resource |
| [morpheus_instance_layout.tf_example_instance_layout](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/instance_layout) | resource |
| [morpheus_instance_type.tf_example_instance_type](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/instance_type) | resource |
| [morpheus_node_type.tf_example_node](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/resources/node_type) | resource |
| [random_integer.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [morpheus_cloud.cloud](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/data-sources/cloud) | data source |
| [morpheus_virtual_image.example_virtual_image](https://registry.terraform.io/providers/gomorpheus/morpheus/latest/docs/data-sources/virtual_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud"></a> [cloud](#input\_cloud) | cloud name | `string` | n/a | yes |
| <a name="input_group"></a> [group](#input\_group) | group name root | `string` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | image name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_id"></a> [cloud\_id](#output\_cloud\_id) | The ID of the cloud input |
| <a name="output_group_code"></a> [group\_code](#output\_group\_code) | The code of the group created |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The ID of the group created |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The name of the group created |
| <a name="output_instance_layout_id"></a> [instance\_layout\_id](#output\_instance\_layout\_id) | The ID of the instance type created |
| <a name="output_instance_layout_name"></a> [instance\_layout\_name](#output\_instance\_layout\_name) | The name of the instance type created |
| <a name="output_instance_type_code"></a> [instance\_type\_code](#output\_instance\_type\_code) | The code of the instance type created |
| <a name="output_instance_type_name"></a> [instance\_type\_name](#output\_instance\_type\_name) | The name of the instance type created |
| <a name="output_node_type_id"></a> [node\_type\_id](#output\_node\_type\_id) | The ID of the node type created |
| <a name="output_node_type_name"></a> [node\_type\_name](#output\_node\_type\_name) | The name of the node type created |
<!-- END_TF_DOCS -->