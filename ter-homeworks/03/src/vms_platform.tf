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

variable "vms_resources" {
    type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
        cores=2
        memory=1
        core_fraction=20
    }    
  }
}

variable "vms_db_resources" {
    type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
        main = {
        cores=4
        memory=2
        core_fraction=20
    },
    replica = {
        cores=2
        memory=1
        core_fraction=20
    }
  }
}