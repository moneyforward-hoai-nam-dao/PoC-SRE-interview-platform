terraform {
  backend "s3" {
    bucket  = "s3-backend-pbl-scenario-1"
    key     = "terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }
}
