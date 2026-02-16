module "grafana-folders" {
  source = "../Modules/Grafana/Folders"
}

module "homelab-dashboard" {
  source = "../Modules/Grafana/Dashboards"

  k8s_folder_uid            = module.grafana-folders.k8s.uid
  loki_folder_uid           = module.grafana-folders.loki.uid
  prometheus_datasource_uid = "eepxvs3drobnkc"
}