provider "google" {
  project = "playground-s-11-5f7d5dd3"
  region  = "us-central1"  # Adjust as necessary
}

# Define a list of APIs to be enabled
locals {
  api_services = [
    "container.googleapis.com",   # Google Kubernetes Engine (GKE)
    "cloudbuild.googleapis.com",  # Cloud Build
    "monitoring.googleapis.com",  # Cloud Monitoring
    "logging.googleapis.com",     # Cloud Logging
    "storage.googleapis.com",     # Google Cloud Storage
    "compute.googleapis.com"      # Google Compute Engine
    # Add more APIs as needed
  ]
}

# Enable APIs
resource "google_project_service" "apis" {
  for_each = toset(local.api_services)
  project  = "playground-s-11-5f7d5dd3"
  service  = each.value
}
