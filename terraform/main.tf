provider "google" {
  project = "showcase-404910"
  region  = "eu-central2"
}

resource "random_id" "id" {
  byte_length = 8
}

resource "google_storage_bucket" "my-bucket" {
  location = "EU"
  name     = "my-bucket-${random_id.id.hex}"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "main-page" {
  bucket = google_storage_bucket.my-bucket.name
  name   = "index.html"
  source = "../app/index.html"
}

resource "google_storage_bucket_object" "not-found-page" {
  bucket = google_storage_bucket.my-bucket.name
  name   = "404.html"
  source = "../app/404.html"
}

resource "google_storage_bucket_iam_binding" "bucket-iam-binding" {
  bucket  = google_storage_bucket.my-bucket.name
  role    = "roles/storage.objectViewer"
  members = ["allUsers"]
}

output "mainPageUrl" {
  value = "https://storage.googleapis.com/${google_storage_bucket.my-bucket.name}/${google_storage_bucket_object.main-page.name}"
}

output "notFoundPageUrl" {
  value = "https://storage.googleapis.com/${google_storage_bucket.my-bucket.name}/${google_storage_bucket_object.not-found-page.name}"
}