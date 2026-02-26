locals {
  grafana_panels = [
    # Grafana Pod CPU 使用量
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "core"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 0 },
      "id" : 1,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\",pod=~\".*grafana-.*\"}[5m]))",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Grafana Pod CPU 使用量",
      "type" : "timeseries"
    },
    # Grafana Pod Memory 使用量
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "bytes"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 0 },
      "id" : 2,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\",pod=~\".*grafana-.*\"})",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Grafana Pod Memory 使用量",
      "type" : "timeseries"
    },
    # Grafana自体のレイテンシー（95 percentile）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "grafana_instance | handler | status_code",
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "s"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 0 },
      "id" : 3,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "histogram_quantile(0.95, (sum by(handler,grafana_instance,le,status_code)(rate(grafana_http_request_duration_seconds_bucket{handler=~\"/api/ds/query|/api/dashboards/uid/.*|/api/search/\"}[5m]))))",
        "hide" : false,
        "legendFormat" : "{{grafana_instance}} | {{handler}} | {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "Grafana自体のレイテンシー（95 percentile）",
      "type" : "timeseries"
    },
    # DataSource レイテンシー（95 percentile）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "grafana_instance | datasource_type | datasource | status_code",
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "s"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 0 },
      "id" : 4,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "histogram_quantile(0.95, (sum by(datasource,datasource_type,grafana_instance,le,code)(rate(grafana_datasource_request_duration_seconds_bucket[5m]))))",
        "hide" : false,
        "legendFormat" : "{{grafana_instance}} | {{datasource_type}} | {{datasource}} | {{code}}", "range" : true, "refId" : "A"
      }],
      "title" : "DataSource レイテンシー（95 percentile）",
      "type" : "timeseries"
    },
    # Grafana自体の5xxエラー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "grafana_instance | handler | status_code",
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 10 },
      "id" : 5,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(grafana_instance,handler,status_code)(round(increase(grafana_http_request_duration_seconds_count{status_code=~\"5..\"}[5m])))",
        "legendFormat" : "{{grafana_instance}} | {{handler}} | {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "Grafana自体の5xxエラー",
      "type" : "timeseries"
    },
    # DataSource 5xxエラー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "grafana_instance | datasource | datasource_type | code",
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 10 },
      "id" : 6,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(grafana_instance,code,datasource,datasource_type)(round(increase(grafana_datasource_request_duration_seconds_count{code=~\"5..\"}[5m])))",
        "legendFormat" : "{{grafana_instance}} | {{datasource}} | {{datasource_type}} | {{code}}", "range" : true, "refId" : "A"
      }],
      "title" : "DataSource 5xxエラー",
      "type" : "timeseries"
    },
    # Active ユーザ数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 10 },
      "id" : 7,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(grafana_instance)(grafana_stat_active_users)",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Active ユーザ数",
      "type" : "timeseries"
    },
    # ダッシュボード数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 15, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 10 },
      "id" : 8,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(grafana_instance)(grafana_stat_totals_dashboard)",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "ダッシュボード数",
      "type" : "timeseries"
    },
  ]
}
