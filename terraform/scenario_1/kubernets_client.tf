resource "kubernetes_deployment" "test-client" {
  provider = kubernetes.k8s-client
  metadata {
    name = var.metadata_k8s_client
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.app_label_client
      }
    }
    template {
      metadata {
        labels = {
          app = var.app_label_client
        }
      }
      spec {
        container {
          image = var.image_id
          name  = var.container_name
          env {
            name  = "AWS_ACCESS_KEY_ID"
            value = var.aws_access_key
          }
          env {
            name  = "AWS_SECRET_ACCESS_KEY"
            value = var.aws_secret_key
          }
        }
      }
    }
  }

  depends_on = [
    aws_eks_node_group.client
  ]
}
