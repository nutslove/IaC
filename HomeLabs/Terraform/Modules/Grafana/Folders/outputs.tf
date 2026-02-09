output "k8s" {
  description = "k8s folder resource"
  value       = grafana_folder.k8s
}

output "loki" {
  description = "Loki folder resource"
  value       = grafana_folder.loki
}

output "thanos" {
  description = "Thanos folder resource"
  value       = grafana_folder.thanos
}

output "tempo" {
  description = "Tempo folder resource"
  value       = grafana_folder.tempo
}

output "langfuse" {
  description = "Langfuse folder resource"
  value       = grafana_folder.langfuse
}

output "argocd" {
  description = "ArgoCD folder resource"
  value       = grafana_folder.argocd
}