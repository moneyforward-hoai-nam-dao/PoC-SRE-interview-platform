#############################################
# Common variables
#############################################
variable "project" {
  default = "pbl-04-2022"
}

variable "region" {
  default = "ap-southeast-1"
}

#############################################
# EKS cluster variables
#############################################
variable "tags" {
  type = map(string)
  default = {
    "project"     = "PBL-04-2022"
    "environment" = "test"
    "Owner"       = "Hoai Nam Dao"
  }
}

variable "cluster_version" {
  default = "1.21"
}

variable "eks_cluster_client_name" {
  default = "pbl-04-2022-cluster-client"
}

variable "node_group_name" {
  default = "nodegroup-client"
}

variable "ami_type" {
  default = "AL2_ARM_64"
}

variable "instance_type" {
  default = "a1.large"
}

variable "disk_size" {
  default = 20
}

variable "capacity_size" {
  default = "ON_DEMAND"
}

#############################################
# K8S variables
#############################################
variable "metadata_k8s_client" {
  default = "go-client"
}

variable "app_label_client" {
  default = "myClient"
}

variable "image_id" {
  default = "public.ecr.aws/z4g4b9e1/sre_pbl_go_client:v4"
}

variable "container_name" {
  default = "go-client-container"
}
