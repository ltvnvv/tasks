resource "yandex_storage_bucket" "tf-backend-lv" {
  bucket = "tf-backend-lv"
  folder_id = var.folder_id
}
