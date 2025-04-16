terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.140.1"
    }
  }
  required_version = ">= 1.8.4"


  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    shared_credentials_files = ["~/.aws/credentials"]
    shared_config_files = ["~/.aws/config"]
    profile = "diploma"

    bucket = "tf-backend-lv"
    region = "ru-central1"
    key    = "diploma/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}
