provider "astra" {
  token = var.astra_token
}

provider "aws" {
  region  = "us-west-2"
  profile = var.aws_profile
}
