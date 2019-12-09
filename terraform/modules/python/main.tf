resource "kubernetes_service" "frontendsvc" {
  metadata {
    name = "frontendsvc"
  }

  spec {
    selector = {
      app = "${kubernetes_deployment.frontend.metadata.0.labels.app}"
    }

    port {
      port        = 5001
      target_port = 5001
      node_port   = 30000
    }

    type = "NodePort"
  }

  depends_on = ["kubernetes_deployment.frontend"]
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"

    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = "deepakjotwani/pythonfrontend:latest"
        }
      }
    }
  }

}
