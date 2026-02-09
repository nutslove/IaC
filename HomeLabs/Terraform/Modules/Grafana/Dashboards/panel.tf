locals {
  k8s_panels = [
    # ダッシュボード概要テキストパネル
    {
      "fieldConfig" : { "defaults" : {}, "overrides" : [] },
      "gridPos" : { "h" : 3, "w" : 5, "x" : 0, "y" : 0 },
      "id" : 16,
      "options" : {
        "code" : { "language" : "plaintext", "showLineNumbers" : false, "showMiniMap" : false },
        "content" : "## 本ダッシュボードの概要\n- K8sクラスター全体の可溶性を確認するためのダッシュボード\n- ノード、Pod、Kubernetesのリソースなどの指標を確認",
        "mode" : "markdown"
      },
      "pluginVersion" : "12.0.6",
      "title" : "",
      "type" : "text"
    },
    # Total Node数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "thresholds" },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 3, "w" : 2, "x" : 5, "y" : 0 },
      "id" : 19,
      "options" : {
        "colorMode" : "value", "graphMode" : "none", "justifyMode" : "auto",
        "orientation" : "auto", "percentChangeColorMode" : "standard",
        "reduceOptions" : { "calcs" : ["lastNotNull"], "fields" : "", "values" : false },
        "showPercentChange" : false, "textMode" : "auto", "wideLayout" : true
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "count(kube_node_info)",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Total Node数",
      "type" : "stat"
    },
    # EKSクラスター行ヘッダー
    {
      "collapsed" : false,
      "gridPos" : { "h" : 1, "w" : 24, "x" : 0, "y" : 3 },
      "id" : 6,
      "panels" : [],
      "title" : "EKSクラスター",
      "type" : "row"
    },
    # ワーカーノード CPU使用率
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 90 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 4 },
      "id" : 4,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "100 - (avg by (instance) (rate(node_cpu_seconds_total{mode=\"idle\"}[5m])) * 100)",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "ワーカーノード CPU使用率",
      "type" : "timeseries"
    },
    # ワーカーノード Memory使用率
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "fieldMinMax" : false, "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 4 },
      "id" : 8,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "100 * (1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)",
        "instant" : false, "legendFormat" : "{{kubernetes_io_hostname}}", "range" : true, "refId" : "A"
      }],
      "title" : "ワーカーノード Memory使用率",
      "type" : "timeseries"
    },
    # ワーカーノード Disk使用率
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 97,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 4 },
      "id" : 5,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "100 * (1 - node_filesystem_avail_bytes{fstype!~\"tmpfs|overlay\",mountpoint=\"/\"} / node_filesystem_size_bytes{fstype!~\"tmpfs|overlay\",mountpoint=\"/\"})",
        "instant" : false, "legendFormat" : "{{kubernetes_io_hostname}}", "range" : true, "refId" : "A"
      }],
      "title" : "ワーカーノード Disk使用率",
      "type" : "timeseries"
    },
    # ワーカーノード Network送受信
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
          "decimals" : 0, "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "binbps"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 4 },
      "id" : 15,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "sum by(instance)(rate(container_network_receive_bytes_total[5m]))*8",
          "instant" : false, "legendFormat" : "{{instance}} / 受信", "range" : true, "refId" : "A"
        },
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "sum by(instance)(rate(container_network_transmit_bytes_total[5m]))*8",
          "hide" : false, "instant" : false, "legendFormat" : "{{instance}} / 送信", "range" : true, "refId" : "B"
        }
      ],
      "title" : "ワーカーノード Network送受信",
      "type" : "timeseries"
    },
    # Pod合計のCPU Request / ワーカーノードのCPUコア
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 70 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 14 },
      "id" : 9,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (node) (kube_pod_container_resource_requests{resource=\"cpu\"}) / on (node) kube_node_status_allocatable{resource=\"cpu\"} * 100",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Pod合計のCPU Request / ワーカーノードのCPUコア",
      "type" : "timeseries"
    },
    # Pod合計のCPU Limit / ワーカーノードのCPUコア
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
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 14 },
      "id" : 11,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (node) (kube_pod_container_resource_limits{resource=\"cpu\"}) / on (node) kube_node_status_allocatable{resource=\"cpu\"} * 100",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Pod合計のCPU Limit / ワーカーノードのCPUコア",
      "type" : "timeseries"
    },
    # Pod合計のMemory Request / ワーカーノードのMemory
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 60 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 14 },
      "id" : 10,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (node) (kube_pod_container_resource_requests{resource=\"memory\"}) / on (node) kube_node_status_allocatable{resource=\"memory\"} * 100",
        "hide" : false, "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Pod合計のMemory Request / ワーカーノードのMemory",
      "type" : "timeseries"
    },
    # Pod合計のMemory Limit / ワーカーノードのMemory
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 14 },
      "id" : 12,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (node) (kube_pod_container_resource_limits{resource=\"memory\"}) / on (node) kube_node_status_allocatable{resource=\"memory\"} * 100",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Pod合計のMemory Limit / ワーカーノードのMemory",
      "type" : "timeseries"
    },
    # Running Pod数 / Desired Pod数（率）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "palette-classic" },
          "custom" : {
            "axisBorderShow" : false, "axisCenteredZero" : false, "axisColorMode" : "series",
            "axisLabel" : "", "axisPlacement" : "auto", "barAlignment" : 0, "barWidthFactor" : 0.6,
            "drawStyle" : "line", "fillOpacity" : 0, "gradientMode" : "none",
            "hideFrom" : { "legend" : false, "tooltip" : false, "viz" : false },
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 5,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 24 },
      "id" : 7,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "asc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "kube_deployment_status_replicas_available / kube_deployment_spec_replicas * 100",
          "instant" : false, "legendFormat" : "{{deployment}}", "range" : true, "refId" : "A"
        },
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "kube_statefulset_status_replicas_ready / kube_statefulset_replicas * 100",
          "hide" : false, "instant" : false, "legendFormat" : "{{statefulset}}", "range" : true, "refId" : "C"
        }
      ],
      "title" : "Running Pod数 / Disired Pod数（率）",
      "type" : "timeseries"
    },
    # Pod CPU使用量
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "container!=\"POD\" は pause container を除外、container!=\"\" は集約行を除外するためのフィルタ",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 24 },
      "id" : 3,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\"}[5m]))",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod CPU使用量",
      "type" : "timeseries"
    },
    # Pod Memory使用量
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "container_memory_working_set_bytes はOOM判定に使われる実質的なメモリ使用量（推奨）\ncontainer_memory_usage_bytesはキャッシュ含む総使用量",
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
          "unit" : "gbytes"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 24 },
      "id" : 18,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\"}) / 1024 / 1024 / 1024",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod Memory使用量",
      "type" : "timeseries"
    },
    # Pod Network送受信
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "pod!=\"\"は集約行を除外するため",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 24 },
      "id" : 17,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "sum by (namespace, pod) (rate(container_network_receive_bytes_total{pod!=\"\"}[5m]))",
          "instant" : false, "legendFormat" : "{{pod}} / 受信", "range" : true, "refId" : "A"
        },
        {
          "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
          "editorMode" : "code",
          "expr" : "sum by (namespace, pod) (rate(container_network_transmit_bytes_total{pod!=\"\"}[5m]))",
          "hide" : false, "instant" : false, "legendFormat" : "{{pod}} / 送信", "range" : true, "refId" : "B"
        }
      ],
      "title" : "Pod Network送受信",
      "type" : "timeseries"
    },
    # Pod CPU使用率（対Request）
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
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 34 },
      "id" : 20,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod, container) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\"}[5m]))\n/ on (namespace, pod, container) kube_pod_container_resource_requests{resource=\"cpu\"} * 100",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod CPU使用率（対Request）",
      "type" : "timeseries"
    },
    # Pod CPU使用率（対Limit）
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 34 },
      "id" : 21,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod, container) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\"}[5m]))\n/ on (namespace, pod, container) kube_pod_container_resource_limits{resource=\"cpu\"} * 100",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod CPU使用率（対Limit）",
      "type" : "timeseries"
    },
    # Pod Memory使用率（対Request）
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
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 34 },
      "id" : 22,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod, container) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\"})\n/ on (namespace, pod, container) kube_pod_container_resource_requests{resource=\"memory\"} * 100",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod Memory使用率（対Request）",
      "type" : "timeseries"
    },
    # Pod Memory使用率（対Limit）
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 34 },
      "id" : 23,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod, container) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\"})\n/ on (namespace, pod, container) kube_pod_container_resource_limits{resource=\"memory\"} * 100",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod Memory使用率（対Limit）",
      "type" : "timeseries"
    },
    # OOM KilledによるPod再起動回数
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
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 6,
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 44 },
      "id" : 24,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "floor(increase(kube_pod_container_status_restarts_total[5m]) and on (namespace, pod, container) kube_pod_container_status_last_terminated_reason{reason=\"OOMKilled\"})",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "OOM KilledによるPod再起動回数",
      "type" : "timeseries"
    },
    # Pod CPU スロットリング率（%）
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
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 6,
            "scaleDistribution" : { "type" : "linear" }, "showPoints" : "auto", "spanNulls" : false,
            "stacking" : { "group" : "A", "mode" : "none" },
            "thresholdsStyle" : { "mode" : "off" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 44 },
      "id" : 25,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod, container) (rate(container_cpu_cfs_throttled_periods_total{container!=\"\", container!=\"POD\"}[5m])) / \nsum by (namespace, pod, container) (rate(container_cpu_cfs_periods_total{container!=\"\", container!=\"POD\"}[5m])) * 100",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod CPU スロットリング率（%）",
      "type" : "timeseries"
    },
    # Pod CPU スロットリングされた時間（秒）
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
            "insertNulls" : false, "lineInterpolation" : "linear", "lineWidth" : 2, "pointSize" : 6,
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 44 },
      "id" : 26,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod, container) (rate(container_cpu_cfs_throttled_seconds_total{container!=\"\", container!=\"POD\"}[5m]))",
        "instant" : false, "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Pod CPU スロットリングされた時間（秒）",
      "type" : "timeseries"
    },
    # PV（EBS）使用率
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
            "thresholdsStyle" : { "mode" : "dashed" }
          },
          "mappings" : [], "max" : 100,
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
          },
          "unit" : "percent"
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 44 },
      "id" : 1,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "none" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "(kubelet_volume_stats_used_bytes / kubelet_volume_stats_capacity_bytes) * 100",
        "instant" : false, "legendFormat" : "{{persistentvolumeclaim}}", "range" : true, "refId" : "A"
      }],
      "title" : "PV（EBS）使用率",
      "type" : "timeseries"
    },
    # ワーカーノードごとのPod数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "thresholds" },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 0, "y" : 54 },
      "id" : 13,
      "options" : {
        "colorMode" : "value", "graphMode" : "none", "justifyMode" : "center",
        "orientation" : "auto", "percentChangeColorMode" : "standard",
        "reduceOptions" : { "calcs" : ["lastNotNull"], "fields" : "", "values" : false },
        "showPercentChange" : false, "text" : {}, "textMode" : "auto", "wideLayout" : true
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (node) (kube_pod_info)",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "ワーカーノードごとのPod数",
      "type" : "stat"
    },
    # namespaceごとのPod数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "fieldConfig" : {
        "defaults" : {
          "color" : { "mode" : "thresholds" },
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }]
          }
        },
        "overrides" : []
      },
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 54 },
      "id" : 2,
      "options" : {
        "colorMode" : "value", "graphMode" : "none", "justifyMode" : "center",
        "orientation" : "auto", "percentChangeColorMode" : "standard",
        "reduceOptions" : { "calcs" : ["lastNotNull"], "fields" : "", "values" : false },
        "showPercentChange" : false, "textMode" : "auto", "wideLayout" : true
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace) (kube_pod_info)",
        "instant" : false, "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "namespaceごとのPod数",
      "type" : "stat"
    }
  ]
}