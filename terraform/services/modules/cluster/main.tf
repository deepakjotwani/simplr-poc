# Generate unique cluster profix
resource "random_id" "cluster" {
  byte_length = 4
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.cluster_name_prefix}-${terraform.workspace}-${random_id.cluster.hex}"
  project                  = var.admin_project
  location                 = var.region
  initial_node_count       = var.initial_node_count

  # GKE cluster version
  node_version             = var.node_version
  min_master_version       = var.node_version

  # Do not use default node pool
  remove_default_node_pool = true

  ip_allocation_policy {
  }

  # Logging and Monitoring
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  # Authentication
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Addons
  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }
}
