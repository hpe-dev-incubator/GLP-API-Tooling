# (C) Copyright 2021-2025 Hewlett Packard Enterprise Development LP

#  Set-up for terraform >= v0.0.1
terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
      version = ">= 0.0.1"
    }
    morpheus = {
      source  = "gomorpheus/morpheus"
      version = ">= 0.0.1"
    }
  }
}

# Morpheus
provider "morpheus" {
  url          = data.hpegl_vmaas_morpheus_details.morpheus_details.url
  access_token = data.hpegl_vmaas_morpheus_details.morpheus_details.access_token
}

# hpegl
provider "hpegl" {
  vmaas {
    location   = var.location
    space_name = var.space
  }
}

data "hpegl_vmaas_morpheus_details" "morpheus_details" {}

# Get Cloud ID
data "morpheus_cloud" "cloud" {
  name = var.cloud
}

data "hpegl_vmaas_datastore" "c_3par" {
  cloud_id = data.morpheus_cloud.cloud.id
  name     = var.datastore
}

data "hpegl_vmaas_network" "blue_segment" {
  name = var.network
}

resource "random_integer" "random" {
  min = 1
  max = 50000
}

data "hpegl_vmaas_resource_pool" "cl_resource_pool" {
  cloud_id = data.morpheus_cloud.cloud.id
  name     = var.resource_pool
}


data "hpegl_vmaas_plan" "g1_large" {
  name = var.service_plan
}

data "hpegl_vmaas_environment" "env" {
  name = var.environment
}

data "hpegl_vmaas_cloud_folder" "compute_folder" {
  cloud_id = data.morpheus_cloud.cloud.id
  name     = var.compute_folder
}

data "morpheus_virtual_image" "example_virtual_image" {
  name = var.image_name
}

# Create Infrastructure Group
resource "morpheus_group" "tf_example_group" {
  name      = var.group
  code      = var.group
  location  = "galway"
  cloud_ids = [data.morpheus_cloud.cloud.id]
}

# Create Node Type
resource "morpheus_node_type" "tf_example_node" {
  name             = "cfe_tf_example_node_type_1"
  short_name       = "tfexamplenodetype1"
  labels           = ["demo", "instance", "terraform"]
  technology       = "vmware"
  version          = "2.0"
  category         = "tfexample"
  virtual_image_id = data.morpheus_virtual_image.example_virtual_image.id
}

# Create instance type
resource "morpheus_instance_type" "tf_example_instance_type" {
  name        = "cfe_tf_example_instance"
  code        = "cfe_tf_example_instance"
  description = "Terraform Example Instance Type"
  labels      = ["demo", "instance", "terraform"]
  category    = "web"
  visibility  = "public"
  featured    = true
}

# Create Layout
resource "morpheus_instance_layout" "tf_example_instance_layout" {
  instance_type_id = morpheus_instance_type.tf_example_instance_type.id
  name             = "cfe_todo_app_frontend"
  labels           = ["demo", "layout", "terraform"]
  version          = "1.0"
  technology       = "vmware"
  node_type_ids    = [morpheus_node_type.tf_example_node.id]
  creatable        = true
}

# Create a VM from new instance type
resource "hpegl_vmaas_instance" "sample_vm" {
  count              = 1
  name               = "${var.instance_name}-${random_integer.random.result}-${count.index}"
  cloud_id           = data.morpheus_cloud.cloud.id
  group_id           = morpheus_group.tf_example_group.id
  layout_id          = morpheus_instance_layout.tf_example_instance_layout.id
  plan_id            = data.hpegl_vmaas_plan.g1_large.id
  instance_type_code = morpheus_instance_type.tf_example_instance_type.code
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
    purpose           = "sample"
    Division          = "AUK"
    ResourcePurpose   = "CFE"
    ResourceContact   = "john.lenihan@hpe.com"
    APPLICATION       = "Custom Ubuntu"
    BillingCostCenter = "999"
    PatchGroup        = "None"
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
