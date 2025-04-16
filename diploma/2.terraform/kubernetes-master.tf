resource "yandex_kubernetes_cluster" "diploma-cluster" {
  name        = "diploma-cluster"
  description = "Diploma cluster"

  network_id = "${yandex_vpc_network.network-vpc.id}"

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = "${yandex_vpc_subnet.subnet-a.zone}"
        subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.subnet-b.zone}"
        subnet_id = "${yandex_vpc_subnet.subnet-b.id}"
      }

      location {
        zone      = "${yandex_vpc_subnet.subnet-d.zone}"
        subnet_id = "${yandex_vpc_subnet.subnet-d.id}"
      }
    }

    version   = "1.29"
    public_ip = true

    maintenance_policy {
      auto_upgrade = true
    }
    
  }

  service_account_id      = var.sa_id
  node_service_account_id = var.sa_id

  release_channel = "STABLE"
}
