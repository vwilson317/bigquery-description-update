provider "google-beta" {
  # credentials = "${file("google-creds.json")}"
  project     = "project--2656263395406245040"
  region      = "us-east1"
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = "project--2656263395406245040:test"
  friendly_name               = "test"
  description                 = "I don't care"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels {
    env = "default"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = "${google_bigquery_dataset.default.dataset_id}"
  table_id   = "project--2656263395406245040:test.cars"

  time_partitioning {
    type = "DAY"
  }

  labels {
    env = "default"
  }

  schema = "${file("car-schema.json")}"
}