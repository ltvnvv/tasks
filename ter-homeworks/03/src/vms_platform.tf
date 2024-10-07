###instance_vars

variable "vm_web_count" {
  type        = number
  default     = 2
  description = "Number of web VMs"
}

variable "vm_web_image_families" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OS-families"
}

variable "vm_web_instance_name" {
  type        = string
  default     = "web"
  description = "Instance name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platforms ID"
}