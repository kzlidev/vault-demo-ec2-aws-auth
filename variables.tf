variable "app_a_prefix" {
  default = "app-a"
}

variable "app_b_prefix" {
  default = "app-b"
}

variable "prefix" {
  default = "likz"
}

variable "db_username" {
  type    = string
  default = "dbadmin"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "likz-vpc"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR Range for VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "account_id" {
  type    = string
}

variable "vault_addr" {
  type    = string
}

variable "vault_namespace" {
  type    = string
  default = "admin"
}

variable "common_name" {
  type = string
  default = "testweb.com"
}