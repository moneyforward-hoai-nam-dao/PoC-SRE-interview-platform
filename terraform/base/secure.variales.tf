variable "aws_access_key" {
  description = "Access key to test account AWS"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "Secret key to test account AWS"
  type        = string
  sensitive   = true
}

variable "number_replicas_pod" {
  description = "Number of replicase pod at server side"
  sensitive = true
}

variable "is_open_port_80_for_alb" {
  description = "Open port 80 in ingress, client can connect to ALB"
  sensitive = true
}