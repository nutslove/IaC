module "grafana-folders" {
  source = "../../../modules/grafana/folders"
}

module "k8s-dashboard" {
  source = "../../../modules/grafana/dashboards/k8s_dashboard"

  k8s_folder_uid            = module.grafana-folders.k8s.uid
  prometheus_datasource_uid = "eepxvs3drobnkc"
}