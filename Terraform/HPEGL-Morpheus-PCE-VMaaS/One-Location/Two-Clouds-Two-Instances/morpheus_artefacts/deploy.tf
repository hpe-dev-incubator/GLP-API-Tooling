# (C) Copyright 2021-2025 Hewlett Packard Enterprise Development LP
terraform {
  required_providers {
    morpheus = {
      source = "gomorpheus/morpheus"
    }
  }
}

resource "random_integer" "random" {
  min = 1
  max = 50000

  # Keep the random integer unique to the cloud
  keepers = {
    cloud = var.cloud
  }
}

# Get Cloud ID
data "morpheus_cloud" "cloud" {
  name = var.cloud
}

# Create Infrastructure Group
resource "morpheus_group" "tf_example_group" {
  name      = "${var.group}-${random_integer.random.result}"
  code      = "${var.group}-${random_integer.random.result}"
  location  = "galway"
  cloud_ids = [data.morpheus_cloud.cloud.id]
}

# Create instance type
resource "morpheus_instance_type" "tf_example_instance_type" {
  name        = "cfe_tf_example_instance--${random_integer.random.result}"
  code        = "cfe_tf_example_instance--${random_integer.random.result}"
  description = "Terraform Example Instance Type"
  labels      = ["demo", "instance", "terraform"]
  category    = "web"
  visibility  = "public"
  featured    = true
}

data "morpheus_virtual_image" "example_virtual_image" {
  name = var.image_name
}

# Create Node Type
resource "morpheus_node_type" "tf_example_node" {
  name             = "cfe_tf_example_node_type--${random_integer.random.result}"
  short_name       = "tfexamplenodetype-${data.morpheus_virtual_image.example_virtual_image.name}"
  labels           = ["demo", "instance", "terraform"]
  technology       = "vmware"
  version          = "2.0"
  category         = "tfexample"
  virtual_image_id = data.morpheus_virtual_image.example_virtual_image.id
}

# Create Layout
resource "morpheus_instance_layout" "tf_example_instance_layout" {
  instance_type_id = morpheus_instance_type.tf_example_instance_type.id
  name             = "cfe_todo_app_frontend--${random_integer.random.result}"
  labels           = ["demo", "layout", "terraform"]
  version          = "1.0"
  technology       = "vmware"
  node_type_ids    = [morpheus_node_type.tf_example_node.id]
  creatable        = true
}

