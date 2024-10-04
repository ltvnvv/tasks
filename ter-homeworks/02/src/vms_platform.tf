###instance_vars

variable "vm_web_image_families" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OS-families"
}

variable "vm_web_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instance name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platforms ID"
}

###db-instance-var

variable "vm_db_image_families" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OS-families"
}

variable "vm_db_instance_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Instance name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platforms ID"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop-db"
  description = "VPC name DB"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "AZ DB"
}

variable "vm_db_cidr" {
  type        = list
  default     = ["10.0.2.0/24"]
  description = "CIDR DB"
}