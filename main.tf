provider "google" {
  project = "playground-s-11-5f7d5dd3"
  region  = "us-central1"
}

# Define a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "primary" {
  name     = "my-go-rest-api-cluster"
  location = "us-central1-a"

  initial_node_count = 1

  node_config {
    machine_type = "e2-micro"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  enable_legacy_abac = false

  lifecycle {
    # Prevent Terraform from attempting to destroy or recreate this resource
    prevent_destroy = true
    ignore_changes  = [
      # List any attributes you want to ignore changes for
    ]
  }
}


# Enable monitoring and logging APIs
resource "google_project_service" "monitoring" {
  project = "playground-s-11-5f7d5dd3"
  service = "monitoring.googleapis.com"
}

resource "google_project_service" "logging" {
  project = "playground-s-11-5f7d5dd3"
  service = "logging.googleapis.com"
}
