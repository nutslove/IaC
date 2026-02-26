locals {
  thanos_panels = [
    # RPS
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "component | handler (API種別) | tenant | status code",
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
          "unit" : "reqps"
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
        "expr" : "sum by(component,code,handler,tenant)(rate(http_requests_total[5m]))",
        "legendFormat" : "{{component}} | {{handler}} | {{tenant}} | {{code}}", "range" : true, "refId" : "A"
      }],
      "title" : "RPS",
      "type" : "timeseries"
    },
    # レイテンシー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "component | handler (API種別) | tenant | status code | percentile",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 0 },
      "id" : 2,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "histogram_quantile(0.95, sum by(code,component,handler,le,tenant)(rate(http_request_duration_seconds_bucket[5m])))",
          "legendFormat" : "{{component}} | {{handler}} | {{tenant}} | {{code}} | 95 percentile", "range" : true, "refId" : "A"
        },
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "histogram_quantile(0.99, sum by(code,component,handler,le,tenant)(rate(http_request_duration_seconds_bucket[5m])))",
          "hide" : false, "instant" : false,
          "legendFormat" : "{{component}} | {{handler}} | {{tenant}} | {{code}} | 99 percentile", "range" : true, "refId" : "B"
        }
      ],
      "title" : "レイテンシー",
      "type" : "timeseries"
    },
    # compaction失敗数（resolutionごと）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "compactorのcompaction処理失敗数",
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
            "steps" : [{ "color" : "green" }]
          }
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
        "expr" : "sum by(resolution)(round(increase(thanos_compact_group_compactions_failures_total[5m])))",
        "legendFormat" : "{{resolution}} ms", "range" : true, "refId" : "A"
      }],
      "title" : "compaction失敗数（resolutionごと）",
      "type" : "timeseries"
    },
    # compaction成功数（resolutionごと）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "compactorのcompaction処理成功数",
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
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 0 },
      "id" : 11,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(resolution)(round(increase(thanos_compact_group_compactions_total[5m])))",
        "legendFormat" : "{{resolution}} ms", "range" : true, "refId" : "A"
      }],
      "title" : "compaction成功数（resolutionごと）",
      "type" : "timeseries"
    },
    # Receiverレプリケーションエラー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "--receive.replication-factor で設定されたレプリケーションの操作回数。データの耐久性のために、同じデータを複数ノードに複製する処理をカウントする。quorumを満たせたかどうかでresult=\"success\"/\"error\" が分かれる。",
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
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 10 },
      "id" : 6,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(component)(round(increase(thanos_receive_replications_total{result=\"error\"}[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Receiverレプリケーションエラー",
      "type" : "timeseries"
    },
    # Receiver転送エラー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "Receiverがhashringに基づいて他のノードにリクエストを転送した回数。例えばReceiver Aに届いたデータが、hashring的にはReceiver Bが担当すべきものだった場合、AからBへの転送がカウントされる。",
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
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 10 },
      "id" : 12,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(component)(round(increase(thanos_receive_forward_requests_total{result=\"error\"}[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Receiver転送エラー",
      "type" : "timeseries"
    },
    # Object Storage 操作エラー数
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
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 10 },
      "id" : 5,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(component,operation)(round(increase(thanos_objstore_bucket_operation_failures_total[5m])))",
        "legendFormat" : "{{component}} | {{operation}}", "range" : true, "refId" : "A"
      }],
      "title" : "Object Storage 操作エラー数",
      "type" : "timeseries"
    },
    # compact halt
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "0か1の値。1の場合compactorが何かしらの理由でhaltしたということ",
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
          "decimals" : 0, "mappings" : [], "max" : 1,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 10 },
      "id" : 4,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "max(thanos_compact_halted)",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "compact halt",
      "type" : "timeseries"
    },
    # Store Gatewayブロック読み込み失敗数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "Store GatewayがS3バケットからブロックの読み込みに失敗した件数",
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
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 20 },
      "id" : 9,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(component)(round(increase(thanos_bucket_store_block_load_failures_total[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Store Gatewayブロック読み込み失敗数",
      "type" : "timeseries"
    },
    # gRPC エラー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "component | grpc_code | grpc_service",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 20 },
      "id" : 10,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(component,grpc_code,grpc_service)(round(increase(grpc_server_handled_total{grpc_code!=\"OK\",grpc_service=~\"thanos.*\"}[5m])))",
        "hide" : false,
        "legendFormat" : "{{component}} | {{grpc_code}} | {{grpc_service}}", "range" : true, "refId" : "A"
      }],
      "title" : "gRPC エラー",
      "type" : "timeseries"
    },
    # Thanos Pod CPU使用量
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
            "steps" : [{ "color" : "green" }]
          },
          "unit" : "core"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 20 },
      "id" : 7,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\",pod=~\"thanos-.*\"}[5m]))",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Thanos Pod CPU使用量",
      "type" : "timeseries"
    },
    # Thanos Pod Memory使用量
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
            "steps" : [{ "color" : "green" }]
          },
          "unit" : "bytes"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 20 },
      "id" : 8,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\",pod=~\"thanos-.*\"})",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Thanos Pod Memory使用量",
      "type" : "timeseries"
    },
  ]
}
