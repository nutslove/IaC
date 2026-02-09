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
    encrypt        = false  # MinIOではKMSが未設定のためfalseを設定

    endpoint       = "http://192.168.0.176:30793" # APIポート（9000番ポートに対応するNodePortを指定）
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true

    access_key = "QkUFZJbWhexBQYYBG7I7"
    secret_key = "8KC4KNd35FAidowfDAreNd9c3JqqemK9TpdJd891"
  }
}

provider "grafana" {
  url = "http://192.168.0.176:30000"
  auth = "admin:admin123"
}