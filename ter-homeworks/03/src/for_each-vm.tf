resource "yandex_compute_instance" "db" {
  for_each = var.vms_db_resources

  depends_on = [ yandex_compute_instance.web ]

  name        = "${var.vm_web_instance_name}-${each.key}"

  platform_id = var.vm_web_platform_id
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction 
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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