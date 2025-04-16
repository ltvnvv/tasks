//Node group A

resource "yandex_kubernetes_node_group" "diploma-node-group-a" {
  cluster_id  = "${yandex_kubernetes_cluster.diploma-cluster.id}"
  name        = "diploma-node-group-a"
  description = "Diploma node group-a"
  version     = "1.29"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = false
      subnet_ids         = ["${yandex_vpc_subnet.subnet-a.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 32
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

  }
}
//Node group B
resource "yandex_kubernetes_node_group" "diploma-node-group-b" {
  cluster_id  = "${yandex_kubernetes_cluster.diploma-cluster.id}"
  name        = "diploma-node-group-b"
  description = "Diploma node group-b"
  version     = "1.29"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = false
      subnet_ids         = ["${yandex_vpc_subnet.subnet-b.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 32
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

  }
}
//Node group D
resource "yandex_kubernetes_node_group" "diploma-node-group-d" {
  cluster_id  = "${yandex_kubernetes_cluster.diploma-cluster.id}"
  name        = "diploma-node-group-d"
  description = "Diploma node group-d"
  version     = "1.29"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = false
      subnet_ids         = ["${yandex_vpc_subnet.subnet-d.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 32
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-d"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

  }
}
