resource "yandex_vpc_network" "network-vpc" {
  name = "network-vpc"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name = "subnet-a"
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.network-vpc.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-b" {
  name = "subnet-b"
  zone = "ru-central1-b"
  network_id = yandex_vpc_network.network-vpc.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet-d" {
  name = "subnet-d"
  zone = "ru-central1-d"
  network_id = yandex_vpc_network.network-vpc.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}
