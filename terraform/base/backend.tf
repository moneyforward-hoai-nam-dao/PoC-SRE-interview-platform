terraform {
  backend "s3" {
    bucket         = "s3-backend-pbl-base"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}
