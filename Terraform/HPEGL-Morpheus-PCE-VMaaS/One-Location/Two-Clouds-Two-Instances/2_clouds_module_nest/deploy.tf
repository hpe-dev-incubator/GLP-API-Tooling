# (C) Copyright 2025 Hewlett Packard Enterprise Development LP

#  Set-up for terraform >= v0.0.1
terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
      version = "= 0.4.14"
    }
    morpheus = {
      source  = "gomorpheus/morpheus"
      version = ">= 0.0.1"
    }
  }
}

# Hpegl
provider "hpegl" {
  vmaas {
    location   = var.location_1
    space_name = var.space
  }
}

# Morpheus
provider "morpheus" {
  url          = data.hpegl_vmaas_morpheus_details.morpheus_details.url
  access_token = data.hpegl_vmaas_morpheus_details.morpheus_details.access_token
}

# Morpheus details data source
data "hpegl_vmaas_morpheus_details" "morpheus_details" {}

# Group and instance type module
module "morpheus_artefacts_1" {
  source = "../morpheus_artefacts"

  group      = var.group_1
  cloud      = var.cloud_1
  image_name = var.image_name_1
}

module "morpheus_artefacts_2" {
  source = "../morpheus_artefacts"

  group      = var.group_2
  cloud      = var.cloud_2
  image_name = var.image_name_2
}

# Cloud 1
module "instance_cloud_1" {
  source = "../vmaas_instance"

  instance_name  = var.instance_name
  datastore      = var.datastore_1
  network        = var.network_1
  resource_pool  = var.resource_pool_1
  compute_folder = var.compute_folder_1
  layout         = var.layout_1
  service_plan   = var.service_plan_1
  environment    = var.environment

  group_id           = module.morpheus_artefacts_1.group_id
  instance_layout_id = module.morpheus_artefacts_1.instance_layout_id
  instance_type_code = module.morpheus_artefacts_1.instance_type_code
  cloud_id           = module.morpheus_artefacts_1.cloud_id
}

# Cloud 2
module "instance_cloud_2" {
  source = "../vmaas_instance"

  instance_name  = var.instance_name
  datastore      = var.datastore_2
  network        = var.network_2
  resource_pool  = var.resource_pool_2
  compute_folder = var.compute_folder_2
  layout         = var.layout_2
  service_plan   = var.service_plan_2
  environment    = var.environment

  group_id           = module.morpheus_artefacts_2.group_id
  instance_layout_id = module.morpheus_artefacts_2.instance_layout_id
  instance_type_code = module.morpheus_artefacts_2.instance_type_code
  cloud_id           = module.morpheus_artefacts_2.cloud_id
}
