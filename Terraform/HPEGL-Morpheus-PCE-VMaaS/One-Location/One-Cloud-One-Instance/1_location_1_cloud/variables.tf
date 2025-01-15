# (C) Copyright 2021-2024 Hewlett Packard Enterprise Development LP
variable "instance_name" {
  description = "The name for the instance"
  type        = string
}

variable "location" {
  description = "Tenant location"
  type        = string
}

variable "space" {
  description = "space"
  type        = string
}

variable "cloud" {
  description = "cloud"
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

variable "group" {
  description = "group"
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

variable "image_name" {
  description = "image name"
  type        = string
}
