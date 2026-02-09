resource "grafana_folder" "k8s" {
  title = "k8s Cluster"
}

resource "grafana_folder" "loki" {
  title = "Loki"
}

resource "grafana_folder" "thanos" {
  title = "Thanos"
}

resource "grafana_folder" "tempo" {
  title = "Tempo"
}

resource "grafana_folder" "langfuse" {
  title = "Langfuse"
}

resource "grafana_folder" "argocd" {
  title = "ArgoCD"
}