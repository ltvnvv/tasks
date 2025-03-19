### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.

```terraform
resource "yandex_vpc_network" "netology-vpc" {
  name = "netology-vpc"
}
```

2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.

```terraform
resource "yandex_vpc_subnet" "public" {
  name = "subnet-public"
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.netology-vpc.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
```

 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.

```terraform
resource "yandex_compute_instance" "nat-instance" {
  name = "nat-instance"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.254"
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
```

 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.

```terraform
resource "yandex_compute_instance" "public-instance" {
  name = "public-instance"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kc2n656prni2cimp5"
      size = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
```

Подключиться к public-instance и проверить доступ к интернету.

```sh
ssh ubuntu@<public_ip>
ping ya.ru
```

3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.

```terraform
resource "yandex_vpc_subnet" "private" {
  name = "subnet_private"
  zone = "ru-central1-a"
  network_id = yandex_vpc_network.network-vpc.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}
```
 
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.

```terraform
resource "yandex_vpc_route_table" "private_egress" {
  name = "private_egress"
  network_id = yandex_vpc_network.network-vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}
```

Привязать таблицу маршрутизации к приватной сети private:
```terraform
route_table_id = yandex_vpc_route_table.private_egress.id
```

 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

```terraform
resource "yandex_compute_instance" "private-instance" {
  name = "private-instance"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kc2n656prni2cimp5"
      size = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
```

Подключиться к VM по private ip через бастион:
```sh
ssh -J ubuntu@<nat_external_ip> ubuntu@<private_internal_ip>
```
