resource "yandex_compute_disk" "storage" {
  count    = var.disk_count

  size     = var.disk_preference.disk1.size
  type     = var.disk_preference.disk1.type
}

resource "yandex_compute_instance" "storage_vm" {

  name        = var.storage_vm_name

  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction 
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic secondary_disk{
    for_each = "${yandex_compute_disk.storage.*.id}"
   content {
    disk_id = yandex_compute_disk.storage["${secondary_disk.key}"].id
   }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  

  metadata = local.vms_metadata
}