terraform {
    backend "s3" {
        bucket = "terraform-lee"
        key = "lee.prd.tokyo.terraform.tfstate"
        region = "ap-northeast-1"
    }
}

provider "aws" {
    region = "ap-northeast-1"
}