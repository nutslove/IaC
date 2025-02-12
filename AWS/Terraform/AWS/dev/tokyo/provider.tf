terraform {
    backend "s3" {
        bucket = "lee-terraform"
        key = "lee.dev.tokyo.tfstate"
        region = "ap-northeast-1"
    }
}

provider "aws" {
    region = "ap-northeast-1"
}