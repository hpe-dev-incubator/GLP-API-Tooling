# (C) Copyright 2025 Hewlett Packard Enterprise Development LP
output "instance_ids_cloud_1" {
  description = "List of IDs of the instances created for Cloud 1"
  value       = module.instance_cloud_1.instance_id
}

output "instance_names_cloud_1" {
  description = "List of names of the instances created for Cloud 1"
  value       = module.instance_cloud_1.instance_name
}

output "instance_layout_id_cloud_1" {
  description = "The ID of the instance layout created for Cloud 1"
  value       = module.morpheus_artefacts_1.instance_layout_id
}

output "instance_layout_name_cloud_1" {
  description = "The name of the instance layout created for Cloud 1"
  value       = module.morpheus_artefacts_1.instance_layout_name
}

output "node_type_id_cloud_1" {
  description = "The ID of the node type created for Cloud 1"
  value       = module.morpheus_artefacts_1.node_type_id
}

output "node_type_name_cloud_1" {
  description = "The name of the node type created for Cloud 1"
  value       = module.morpheus_artefacts_1.node_type_name
}

output "instance_ids_cloud_2" {
  description = "List of IDs of the instances created for Cloud 2"
  value       = module.instance_cloud_2.instance_id
}

output "instance_names_cloud_2" {
  description = "List of names of the instances created for Cloud 2"
  value       = module.instance_cloud_2.instance_name
}

output "instance_layout_id_cloud_2" {
  description = "The ID of the instance layout created for Cloud 2"
  value       = module.morpheus_artefacts_2.instance_layout_id
}

output "instance_layout_name_cloud_2" {
  description = "The name of the instance layout created for Cloud 2"
  value       = module.morpheus_artefacts_2.instance_layout_name
}

output "node_type_id_cloud_2" {
  description = "The ID of the node type created for Cloud 2"
  value       = module.morpheus_artefacts_2.node_type_id
}

output "node_type_name_cloud_2" {
  description = "The name of the node type created for Cloud 2"
  value       = module.morpheus_artefacts_2.node_type_name
}
