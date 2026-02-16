locals {
  loki_panels = [
    # 429, 5xx リクエスト数
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
        "expr" : "sum by(status_code,route)(round(increase(loki_request_duration_seconds_count{status_code=~\"429|5..\"}[5m])))",
        "legendFormat" : "{{route}} / {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "429, 5xx リクエスト数",
      "type" : "timeseries"
    },
    # レイテンシー（Endpoint別）
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
          "editorMode" : "code", "exemplar" : false,
          "expr" : "histogram_quantile(0.99, sum by(le, route)(rate(loki_request_duration_seconds_bucket[5m])))",
          "legendFormat" : "{{route}} | 99 Percentile", "range" : true, "refId" : "A"
        },
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code", "exemplar" : false,
          "expr" : "histogram_quantile(0.95, sum by(le, route)(rate(loki_request_duration_seconds_bucket[5m])))",
          "hide" : false, "instant" : false,
          "legendFormat" : "{{route}} | 95 Percentile", "range" : true, "refId" : "B"
        }
      ],
      "title" : "レイテンシー（Endpoint別）",
      "type" : "timeseries"
    },
    # Loki distributor 受信ログ数（5m集計）
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
        "expr" : "sum by(tenant)(round(increase(loki_distributor_lines_received_total[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Loki distributor 受信ログ数（5m集計）",
      "type" : "timeseries"
    },
    # Loki distributor 受信Bytes
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
          "unit" : "binBps"
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
        "expr" : "sum by(tenant)(rate(loki_distributor_bytes_received_total[5m]))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Loki distributor 受信Bytes",
      "type" : "timeseries"
    },
    # 破棄されたログ数（5m集計）
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
        "expr" : "sum by(tenant,reason)(round(increase(loki_discarded_samples_total[5m])))",
        "legendFormat" : "{{tenant}} / {{reason}}", "range" : true, "refId" : "A"
      }],
      "title" : "破棄されたログ数（5m集計）",
      "type" : "timeseries"
    },
    # ingesterからObject Storageへのflush件数
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
        "expr" : "sum by(reason)(round(increase(loki_ingester_chunks_flushed_total[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "ingesterからObject Storageへのflush件数",
      "type" : "timeseries"
    },
    # WAL 書き込み失敗件数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "WALで使うディスク容量がいっぱいの場合、WAL書き込みに失敗する",
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
        "expr" : "sum by(pod)(round(increase(loki_ingester_wal_disk_full_failures_total[5m])))",
        "hide" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "WAL 書き込み失敗件数",
      "type" : "timeseries"
    },
    # ingesterのメモリ内にあるstreamの数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "streamの数が多いというのはログのカーディナリティが高いということ",
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
        "expr" : "sum by(tenant)(loki_ingester_memory_streams)",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "ingesterのメモリ内にあるstreamの数",
      "type" : "timeseries"
    },
    # RPS（Memcached）
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
          "unit" : "reqps"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 20 },
      "id" : 10,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(pod,status_code,method)(rate(loki_memcache_request_duration_seconds_count[5m]))",
        "legendFormat" : "{{pod}} / {{method}} / {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "RPS（Memcached）",
      "type" : "timeseries"
    },
    # レイテンシー（Memcached）
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
          "unit" : "s"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 20 },
      "id" : 11,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "histogram_quantile(0.95, sum by(le,method,pod)(rate(loki_memcache_request_duration_seconds_bucket[5m])))",
        "legendFormat" : "{{method}} / {{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "レイテンシー（Memcached）",
      "type" : "timeseries"
    },
    # Loki ring上のUnhealthy, PENDINGの数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "thresholds" },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 20 },
      "id" : 12,
      "options" : {
        "colorMode" : "value", "graphMode" : "none", "justifyMode" : "center",
        "orientation" : "horizontal", "percentChangeColorMode" : "standard",
        "reduceOptions" : { "calcs" : ["lastNotNull"], "fields" : "", "values" : false },
        "showPercentChange" : false, "textMode" : "auto", "wideLayout" : true
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(name,state)(loki_ring_members{state=~\"Unhealthy|PENDING\"})",
        "legendFormat" : "{{name}} / {{state}}", "range" : true, "refId" : "A"
      }],
      "title" : "Loki ring上のUnhealthy, PENDINGの数",
      "type" : "stat"
    },
    # ingesterのメモリ内にあるchunkの数
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 20 },
      "id" : 9,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(pod)(loki_ingester_memory_chunks)",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "ingesterのメモリ内にあるchunkの数",
      "type" : "timeseries"
    },
    # Loki Pod CPU使用量
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 30 },
      "id" : 13,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\",pod=~\"multi-tenant-loki-.*\"}[5m]))",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Loki Pod CPU使用量",
      "type" : "timeseries"
    },
    # Loki Pod Memory使用量
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 30 },
      "id" : 14,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\",pod=~\"multi-tenant-loki-.*\"})",
        "hide" : false, "instant" : false,
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "B"
      }],
      "title" : "Loki Pod Memory使用量",
      "type" : "timeseries"
    },
    # Object Storage 操作エラー数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "LokiがS3等のオブジェクトストレージに対して行う操作（GET, PUT, DELETE, EXISTS等）のうち失敗した回数を記録するカウンター",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 30 },
      "id" : 16,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(component,operation)(round(increase(thanos_objstore_bucket_operation_failures_total[5m])))",
        "hide" : false, "instant" : false,
        "legendFormat" : "{{component}} / {{operation}}", "range" : true, "refId" : "B"
      }],
      "title" : "Object Storage 操作エラー数",
      "type" : "timeseries"
    },
  ]
}