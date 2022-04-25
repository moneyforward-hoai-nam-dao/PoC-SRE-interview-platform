#############################################
# Common variables
#############################################
variable "project" {
  default = "pbl-04-2022"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "pbl"
    "Environment" = "dev"
    "Owner"       = "Hoai Nam Dao"
  }
}

variable "availability_zones_count" {
  description = "The number of AZs."
  type        = number
  default     = 2
}

#############################################
# Network variables
#############################################
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
  default     = 8
}

#############################################
# Launch template variables
#############################################
variable "instance_type" {
  default = "a1.large"
}

variable "launch_template_name" {
  default = "launch_template_for_eks_worker"
}

#############################################
# EKS cluster variables
#############################################
variable "eks_cluster_name" {
  default = "pbl-04-2022-cluster"
}

variable "node_group_name" {
  default = "pbl-04-2022-nodegroup"
}

variable "cluster_version" {
  default = "1.22"
}

variable "min_worker_in_server" {
  default = 1
}

variable "max_worker_in_server" {
  default = 1
}

variable "desired_worker_in_server" {
  default = 1
}

variable "worker_role_name" {
  default = "pbl-04-2022-Worker-Role"
}

#############################################
# K8S variables
#############################################
variable "metadata_k8s" {
  default = "go-server"
}

variable "app_label" {
  default = "myServer"
}

variable "nodePort" {
  default = 31234
}

variable "image_id" {
  default = "public.ecr.aws/z4g4b9e1/sre_pbl_go_server:latest"
}

variable "cpu_limit" {
  default = "20m"
}

variable "mem_limit" {
  default = "50Mi"
}
