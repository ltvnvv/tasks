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
