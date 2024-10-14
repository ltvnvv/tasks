# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

# module "test-vm" {
#   for_each = var.vms_labels
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = "develop" 
#   network_id     = yandex_vpc_network.develop.id
#   subnet_zones   = ["ru-central1-a","ru-central1-b"]
#   subnet_ids     = [yandex_vpc_subnet.develop.id]
#   instance_name  = "${each.key}"
#   image_family   = "ubuntu-2004-lts"
#   public_ip      = true

#   labels = { 
#       project = var.vms_labels[each.key]
#      }

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

# }


module "marketing_vm" {
  #instance_count = 2
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "marketing"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
      project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  #instance_count = 2
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc_dev.network_id
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "analytics"
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
      project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}


data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_public_key = var.vms_ssh_root_key
  }
}