locals {
  tempo_panels = [
    # RPS
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "route | status_code",
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
        "expr" : "sum by(route,status_code)(rate(tempo_request_duration_seconds_count[5m]))",
        "legendFormat" : "{{route}} | {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "RPS",
      "type" : "timeseries"
    },
    # レイテンシー
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "route | status_code",
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
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "histogram_quantile(0.99,sum by(status_code,le,route)(rate(tempo_request_duration_seconds_bucket[5m])))",
        "legendFormat" : "{{route}} | {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "レイテンシー",
      "type" : "timeseries"
    },
    # 受信span数（5m集計）
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
        "expr" : "sum by(tenant)(round(increase(tempo_distributor_spans_received_total[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "受信span数（5m集計）",
      "type" : "timeseries"
    },
    # 破棄されたspan数（5m集計）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "pod | transport",
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
        "expr" : "sum by(pod,transport)(tempo_receiver_refused_spans)",
        "legendFormat" : "{{pod}} | {{transport}}", "range" : true, "refId" : "A"
      }],
      "title" : "破棄されたspan数（5m集計）",
      "type" : "timeseries"
    },
    # RPS（Memcached）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "method | status_code",
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
        "expr" : "sum by(status_code,method)(rate(tempo_memcache_request_duration_seconds_count[5m]))",
        "legendFormat" : "{{method}} | {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "RPS（Memcached）",
      "type" : "timeseries"
    },
    # レイテンシー（Memcached）
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "method | status_code",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 6, "y" : 10 },
      "id" : 7,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "histogram_quantile(0.99,sum by(status_code,le,method)(rate(tempo_memcache_request_duration_seconds_bucket[5m])))",
        "legendFormat" : "{{method}} | {{status_code}}", "range" : true, "refId" : "A"
      }],
      "title" : "レイテンシー（Memcached）",
      "type" : "timeseries"
    },
    # distributor 受信 bytes
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
        "expr" : "sum by(tenant)(rate(tempo_distributor_bytes_received_total[5m]))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "distributor 受信 bytes",
      "type" : "timeseries"
    },
    # クエリー数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "query-frontendが受け付けたクエリの総数\n\noperation | result | tenant",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 10 },
      "id" : 10,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(op,result,tenant)(round(increase(tempo_query_frontend_queries_total[5m])))",
        "legendFormat" : "{{op}} | {{result}} | {{tenant}}", "range" : true, "refId" : "A"
      }],
      "title" : "クエリー数",
      "type" : "timeseries"
    },
    # Tenant Index Builder 稼働状況
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "テナントごとにtenant indexを構築しているインスタンスの数。テナントごとに最低1つのcompactorが1である必要がある。0になるとブロック一覧が更新されず、クエリでトレースが見つからなくなる。",
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
          "decimals" : 0,
          "mappings" : [],
          "thresholds" : {
            "mode" : "absolute",
            "steps" : [{ "color" : "green" }, { "color" : "red", "value" : 80 }]
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
        "expr" : "sum by(tenant)(tempodb_blocklist_tenant_index_builder{pod=~\"multi-tenant-tempo-compactor-.*\"})",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Tenant Index Builder 稼働状況",
      "type" : "timeseries"
    },
    # Tenant Indexエラー数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "tenant indexの取得または構築時に発生したエラーの累積数。増加が見られた場合はcompactorのログを確認する必要がある。（tenant indexの取得と構築の両方のエラーをカウントするカウンター）",
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
      "id" : 8,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(tenant,pod)(round(increase(tempodb_blocklist_tenant_index_errors_total[5m])))",
        "legendFormat" : "{{pod}} | {{tenant}}", "range" : true, "refId" : "A"
      }],
      "title" : "Tenant Indexエラー数",
      "type" : "timeseries"
    },
    # Tenant Indexの鮮度
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "tenant indexが最後に構築・取得されてからの経過秒数。\n\nこの値が大きくなりすぎると以下の影響がある：\n・querier/query-frontendが古いブロック一覧で検索するため、\n  ingesterがフラッシュした新しいブロックがクエリ対象に含まれず\n  トレースが見つからない\n・compaction済みで削除されたブロックへのアクセスが発生し、\n  不要なバックエンドリクエストやエラーの原因になる\n・query-frontendはブロック一覧をもとにクエリをシャーディングするため、\n  古い情報では適切なジョブ分割ができずクエリ性能が劣化する\n\nBuilder稼働状況・Tenant Indexエラー数と合わせて確認すること。",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 12, "y" : 20 },
      "id" : 16,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(tenant,pod)(tempodb_blocklist_tenant_index_age_seconds)",
        "legendFormat" : "{{tenant}} | {{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Tenant Indexの鮮度",
      "type" : "timeseries"
    },
    # compactionされてないblock数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "次のコンパクションサイクルまでに処理が必要な残りのブロック数。継続的に増加している場合はcompactorのスケールアウトが必要。",
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
      "id" : 11,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(tenant)(tempodb_compaction_outstanding_blocks)",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "compactionされてないblock数",
      "type" : "timeseries"
    },
    # Tempo Pod CPU使用量
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
      "id" : 14,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (rate(container_cpu_usage_seconds_total{container!=\"\", container!=\"POD\",pod=~\".*-tempo-.*\"}[5m]))",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Tempo Pod CPU使用量",
      "type" : "timeseries"
    },
    # Tempo Pod Memory使用量
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
      "id" : 15,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by (namespace, pod) (container_memory_working_set_bytes{container!=\"\", container!=\"POD\",pod=~\".*-tempo-.*\"})",
        "legendFormat" : "{{pod}}", "range" : true, "refId" : "A"
      }],
      "title" : "Tempo Pod Memory使用量",
      "type" : "timeseries"
    },
    # Object Storageへのフラッシュ失敗
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "ingesterのObject Storageへのフラッシュ失敗",
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
      "id" : 12,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(pod)(round(increase(tempo_ingester_failed_flushes_total{pod=~\".*ingester.*\"}[5m])))",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "Object Storageへのフラッシュ失敗",
      "type" : "timeseries"
    },
    # 総ブロック数
    {
      "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
      "description" : "増え続けるとクエリパフォーマンス低下の恐れがある",
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
      "gridPos" : { "h" : 10, "w" : 6, "x" : 18, "y" : 30 },
      "id" : 13,
      "options" : {
        "legend" : { "calcs" : [], "displayMode" : "list", "placement" : "bottom", "showLegend" : true },
        "tooltip" : { "hideZeros" : false, "mode" : "multi", "sort" : "desc" }
      },
      "pluginVersion" : "12.0.6",
      "targets" : [{
        "datasource" : { "type" : "prometheus", "uid" : var.prometheus_datasource_uid },
        "editorMode" : "code",
        "expr" : "sum by(tenant)(tempodb_blocklist_length)",
        "legendFormat" : "__auto", "range" : true, "refId" : "A"
      }],
      "title" : "総ブロック数",
      "type" : "timeseries"
    },
  ]
}
