###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

### disk_vm_var
variable "disk_count" {
  type        = number
  default     = 3
  description = "Number of disks"
}

variable "disk_preference" {
    type    = map(object({
    type    = string
    size    = number
  }))

    default = {
        disk1 = {
            type = "network-ssd"
            size = 1
        }
}
}

variable "disk_name" {
  type    = string
  default = "disk"
  description = "Storage disk name"
}

variable "storage_vm_name" {
    type = string
    default = "storage"
    description = "Name of storage VM"
}

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