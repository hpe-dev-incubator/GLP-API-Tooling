# (C) Copyright 2021-2024 Hewlett Packard Enterprise Development LP
variable "instance_name" {
  description = "The name for the instance"
  type        = string
}

variable "datastore" {
  description = "datastore"
  type        = string
}

variable "network" {
  description = "network"
  type        = string
}

variable "instance_type_code" {
  description = "morpheus instance type code"
  type        = string
}

variable "instance_layout_id" {
  description = "instance layout id"
  type        = string
}

variable "group_id" {
  description = "group id"
  type        = string
}

variable "cloud_id" {
    description = "morpheus cloud id, same name as cloud"
    type        = string
}

variable "resource_pool" {
  description = "resourcepool"
  type        = string
}

variable "compute_folder" {
  description = "computefolder"
  type        = string
}

variable "layout" {
  description = "layout"
  type        = string
}

variable "service_plan" {
  description = "serviceplan"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}