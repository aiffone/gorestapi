provider "google" {
  region  = "us-central1"
  project = "playground-s-11-5f7d5dd3"
}

# Enable monitoring and logging services
resource "google_project_service" "monitoring" {
  project = "playground-s-11-5f7d5dd3"
  service = "monitoring.googleapis.com"
}

resource "google_project_service" "logging" {
  project = "playground-s-11-5f7d5dd3"
  service = "logging.googleapis.com"
}

# Define a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "primary" {
  name               = "my-go-rest-api-cluster"
  location           = "us-central1-a"
  initial_node_count = 1

  node_config {
    machine_type = "e2-micro"  # Smallest machine type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # Optional: Define a master version (remove if you want to use the latest version)
  # master_version = "1.22.7-gke.300"

  # Enable legacy authorization (optional, based on your requirements)
  enable_legacy_abac = false


}

# Define the node pool for the cluster
resource "google_container_node_pool" "primary_nodes" {
  name               = "primary-node-pool"
  location           = "us-central1-a"
  cluster            = google_container_cluster.primary.name
  initial_node_count = 1

  node_config {
    machine_type = "e2-micro"  # Smallest machine type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
