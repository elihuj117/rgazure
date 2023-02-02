variable "resource_group_name" {
}

variable "resource_group_location" {
}

variable "vnet_name" {
}

variable "domain" {
}

variable "vnet_cidr" {
}

variable "vpn_cidr" {
}

variable "subnets_private_network" {
  type = list
  default = []
}

variable "subnets_private_name" {
  type = list
  default = []
}

variable "subnets_public_network" {
  type = list
  default = []
}

variable "subnets_public_name" {
  type = list
  default = []
}

variable "subnets_vpn_network" {
  type = list
  default = []
}

variable "subnets_vpn_name" {
  type = list
  default = []
}

variable "subscription_id" {
}

variable "tenant_id" {
}

variable "client_id" {
}

variable "client_secret" {
}