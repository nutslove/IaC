terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 4.0"
    }
  }
}

terraform  {
  backend "s3" {
    bucket         = "home-lab-grafana-tfstate"
    key            = "grafana/home-lab-grafana-terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
  }
}

provider "grafana" {
  url = "http://192.168.0.176:30000"
  auth = "admin:admin123"
}