# (C) Copyright 2024 Hewlett Packard Enterprise Development LP
output "instance_id" {
  description = "List of IDs of the instances created"
  value       = one(hpegl_vmaas_instance.sample_vm[*].id)
}

output "instance_name" {
  description = "List of names of the instances created"
  value       = one(hpegl_vmaas_instance.sample_vm[*].name)
}
