resource "grafana_dashboard" "loki_dashboard" {
  folder = var.loki_folder_uid
  config_json = jsonencode({
    "annotations" : {
      "list" : [
        {
          "builtIn" : 1,
          "datasource" : {
            "type" : "grafana",
            "uid" : "-- Grafana --"
          },
          "enable" : true,
          "hide" : true,
          "iconColor" : "rgba(0, 211, 255, 1)",
          "name" : "Annotations & Alerts",
          "type" : "dashboard"
        }
      ]
    },
    "editable" : true,
    "fiscalYearStartMonth" : 0,
    "graphTooltip" : 0,
    "links" : [],
    "panels" : local.loki_panels,
    "preload" : false,
    "schemaVersion" : 41,
    "tags" : [],
    "templating" : {
      "list" : []
    },
    "time" : {
      "from" : "now-24h",
      "to" : "now"
    },
    "timepicker" : {},
    "timezone" : "browser",
    "title" : "Loki Dashboard",
    "uid" : "loki-dashboard-uid"
  })
}