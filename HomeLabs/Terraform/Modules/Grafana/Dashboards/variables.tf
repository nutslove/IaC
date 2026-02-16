variable "k8s_folder_uid" {
  description = "The UID of the Grafana folder where the monitoring dashboard will be created."
  type        = string
}

variable "loki_folder_uid" {
  description = "The UID of the Grafana folder where the Loki dashboard will be created."
  type        = string
}

variable "prometheus_datasource_uid" {
  description = "The UID of the Prometheus datasource in Grafana."
  type        = string
}