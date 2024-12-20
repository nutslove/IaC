terraform {
    backend "s3" {
        bucket = "senaki-tf"
        key = "senaki.dev.tokyo.tfstate"
        region = "ap-northeast-1"
    }
}

provider "aws" {
    region = "ap-northeast-1"
}