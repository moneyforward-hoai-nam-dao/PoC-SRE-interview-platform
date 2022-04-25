data "aws_vpc" "selected" {
  default    = false
  cidr_block = "10.0.0.0/16"
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "cidr-block"
    values = ["10.0.0.0/24", "10.0.1.0/24"]
  }

}
