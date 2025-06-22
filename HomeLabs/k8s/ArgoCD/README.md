## install
- WorkerNodeが２台しかないのでHAモード（３台から可能）ではインストールできない

```shell
kubectl apply -f namespace.yaml
kubectl apply -n argocd -f install.yaml
```