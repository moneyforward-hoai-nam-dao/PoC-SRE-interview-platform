resource "kubernetes_namespace" "test" {
  metadata {
    name = var.metadata_k8s
  }

  depends_on = [
    aws_eks_node_group.this
  ]
}

resource "kubernetes_deployment" "test" {
  metadata {
    name      = var.metadata_k8s
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = var.number_replicas_pod
    selector {
      match_labels = {
        app = var.app_label
      }
    }
    template {
      metadata {
        labels = {
          app = var.app_label
        }
      }
      spec {
        container {
          image = var.image_id
          name  = "go-server-container"
          port {
            container_port = 80
          }
          resources {
            limits = {
              cpu    =  var.cpu_limit
              memory =  var.mem_limit
            }
          }

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
    aws_eks_node_group.this
  ]
}

resource "kubernetes_service" "test" {
  metadata {
    name      = var.metadata_k8s
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = var.nodePort
      port        = 80
      target_port = 80
    }
  }
  depends_on = [
    aws_eks_node_group.this,
  ]
}
