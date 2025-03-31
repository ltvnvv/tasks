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

resource "yandex_kms_symmetric_key" "lv-cipher-key" {
  name = "lv-cipher-key"
}

resource "yandex_storage_bucket" "lv-20250331" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.lv-sa-editor
  ]
  access_key = yandex_iam_service_account_static_access_key.lv-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.lv-sa-static-key.secret_key
  bucket = "lv-20250331"

  anonymous_access_flags {
    read = true
    list = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.lv-cipher-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

}
