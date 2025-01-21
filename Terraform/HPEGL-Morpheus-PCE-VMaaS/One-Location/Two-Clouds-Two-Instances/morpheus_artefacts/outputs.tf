# (C) Copyright 2025 Hewlett Packard Enterprise Development LP
output "instance_layout_id" {
  description = "The ID of the instance type created"
  value       = morpheus_instance_layout.tf_example_instance_layout.id
}

output "instance_layout_name" {
  description = "The name of the instance type created"
  value       = morpheus_instance_layout.tf_example_instance_layout.name
}

output "instance_type_code" {
  description = "The code of the instance type created"
  value       = morpheus_instance_type.tf_example_instance_type.code
}

output "node_type_id" {
  description = "The ID of the node type created"
  value       = morpheus_node_type.tf_example_node.id
}

output "node_type_name" {
  description = "The name of the node type created"
  value       = morpheus_node_type.tf_example_node.name
}

output "instance_type_name" {
  description = "The name of the instance type created"
  value       = morpheus_instance_type.tf_example_instance_type.name
}

output "group_id" {
  description = "The ID of the group created"
  value       = morpheus_group.tf_example_group.id
}

output "group_name" {
  description = "The name of the group created"
  value       = morpheus_group.tf_example_group.name
}

output "group_code" {
  description = "The code of the group created"
  value       = morpheus_group.tf_example_group.code
}

output "cloud_id" {
  description = "The ID of the cloud input"
  value       = data.morpheus_cloud.cloud.id
}
