# (C) Copyright 2021-2024 Hewlett Packard Enterprise Development LP
terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
    }
    morpheus = {
      source  = "gomorpheus/morpheus"
    }
  }
}

resource "random_integer" "random" {
  min = 1
  max = 50000

  # Keep the random integer unique to the cloud
  keepers = {
   cloud = var.cloud_id
  }
}

data "hpegl_vmaas_datastore" "c_3par" {
  cloud_id = var.cloud_id
  name     = var.datastore
}

data "hpegl_vmaas_network" "blue_segment" {
  name = var.network
}

data "hpegl_vmaas_resource_pool" "cl_resource_pool" {
  cloud_id = var.cloud_id
  name     = var.resource_pool
}

data "hpegl_vmaas_plan" "g1_large" {
  name = var.service_plan
}

data "hpegl_vmaas_environment" "env" {
  name = var.environment
}

data "hpegl_vmaas_cloud_folder" "compute_folder" {
  cloud_id = var.cloud_id
  name     = var.compute_folder
}

# Create a VM from new instance type
resource "hpegl_vmaas_instance" "sample_vm" {
  count              = 1
  name               = "${var.instance_name}-${random_integer.random.result}-${count.index}"
  cloud_id           = var.cloud_id
  group_id           = var.group_id
  layout_id          = var.instance_layout_id
  plan_id            = data.hpegl_vmaas_plan.g1_large.id
  instance_type_code = var.instance_type_code
  network {
    id = data.hpegl_vmaas_network.blue_segment.id
  }
  environment_code = data.hpegl_vmaas_environment.env.code
  volume {
    name         = "root_vol"
    size         = 30
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    root         = true
  }
  labels = ["sample_vm"]
  tags = {
    purpose = "sample"
    Division = "AUK"
    ResourcePurpose = "CFE"
    ResourceContact = "john.lenihan@hpe.com"
    APPLICATION = "Custom Ubuntu"
    BillingCostCenter = "999"
    PatchGroup = "None"
  }
  hostname = "${var.instance_name}-${random_integer.random.result}-${count.index}"
  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    no_agent         = false
    asset_tag        = "vm_tag"
    folder_code      = data.hpegl_vmaas_cloud_folder.compute_folder.code
    create_user      = true
  }
}
