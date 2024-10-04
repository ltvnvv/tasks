### Задание 1

Допущена ошибка в ресурсе "yandex_compute_instance" "platform". Нет платформы типа standart-v4, можно  standard-v3;

core_fraction = 5, Для платформы standard-v3 возможные значения 20, 50, 100

Для платформы standard-v3 cores не может быть равен 1, только 2 или 4

![screenshot](img/1.png)
![screenshot](img/2.png)

Параметры ```preemptible = true``` и ```core_fraction=5``` позволят снизить стоимость VM в облаке.


### Задание 2

```
###instance_vars

variable "vm_web_image_families" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OS-families"
}

variable "vm_web_instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instance name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platforms ID"
}
```

```
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_families
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_instance_name
  platform_id = var.vm_web_platform_id
  resources {...}
```

### Задание 4

Outputs:

vm_info = {
  "instance_name_platform_db" = "netology-develop-platform-db"
  "instance_name_platform_db_fqdn" = "epdu5iepuqa1a0bui11l.auto.internal"
  "instansce_name_platform" = "netology-develop-platform-web"
  "instansce_name_platform_fqdn" = "fhm3q2t88lh4ptkkip91.auto.internal"
  "platform_db_ip" = "158.160.19.202"
  "platform_ip" = "89.169.141.69"
}

### Задание 5