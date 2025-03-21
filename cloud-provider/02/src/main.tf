terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

//
// Create a new Bucket
//

resource "yandex_iam_service_account" "lv-sa" {
  name = "lv-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "lv-sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.lv-sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "lv-sa-static-key" {
  service_account_id = yandex_iam_service_account.lv-sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "lv-20250321" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.lv-sa-editor
  ]
  access_key = yandex_iam_service_account_static_access_key.lv-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.lv-sa-static-key.secret_key
  bucket = "lv-20250321"
}

resource "yandex_storage_object" "lv-picture" {
  access_key = yandex_iam_service_account_static_access_key.lv-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.lv-sa-static-key.secret_key
  bucket = yandex_storage_bucket.lv-20250321.bucket
  key    = "terraform-logo"
  content_type = "image/png"
  source = "./img/terraform-logo.png"
  acl = "public-read"
}

//
// Create a new Compute Instance Group (IG)
//

resource "yandex_vpc_network" "network-vpc" {
  name = "network-vpc"
}

resource "yandex_vpc_subnet" "public" {
  name = "subnet-public"
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.network-vpc.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_resourcemanager_folder_iam_member" "lv-vpc-user" {
  folder_id = var.folder_id
  role      = "vpc.user"
  member    = "serviceAccount:${yandex_iam_service_account.lv-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "lv-global-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.lv-sa.id}"
}

resource "yandex_compute_instance_group" "group1" {
  name                = "test-ig"
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.lv-sa.id

  depends_on = [
    yandex_resourcemanager_folder_iam_member.lv-global-editor,
    yandex_resourcemanager_folder_iam_member.lv-vpc-user
  ]

  deletion_protection = false

  instance_template {
    platform_id = "standard-v1"

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 10
      }
    }

    network_interface {
      network_id = yandex_vpc_network.network-vpc.id
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = file("./cloud-config.yaml")
    }

  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  health_check {
    interval = 5
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
    http_options {
      path = "/index.html"
      port = 80
    }
  }

  deploy_policy {
    max_expansion   = 0
    max_unavailable = 1
  }

}


//
// LB
//

resource "yandex_lb_target_group" "lv-lamp-balancer-group" {
  name      = "lv-lamp-balancer-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.public.id
    address   = yandex_compute_instance_group.group1.instances[0].network_interface[0].ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.public.id
    address   = yandex_compute_instance_group.group1.instances[1].network_interface[0].ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.public.id
    address   = yandex_compute_instance_group.group1.instances[2].network_interface[0].ip_address
  }
}

resource "yandex_lb_network_load_balancer" "lv-lamp-balancer" {
  name = "lv-lamp-balancer"

  listener {
    name = "lv-lamp-balancer-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lv-lamp-balancer-group.id
    healthcheck {
      name = "lv-lamp-balancer-healthcheck"
      http_options {
        port = 80
        path = "/index2.html"
      }
    }
  }
}
