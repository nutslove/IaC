# 目的
- CrossPlaneを使ってAWSリソースを払い出し、Kyvernoを組み合わせてPolicy as a codeを試す

## CrossPlane install
- https://docs.crossplane.io/latest/getting-started/provider-aws/

1. **Helm install**
   - https://helm.sh/ja/docs/intro/install/

2. **CrossPlane install**  
    ```
    helm repo add crossplane-stable https://charts.crossplane.io/stable
    helm repo update

    helm install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace -f values.yaml
    ```
  - `crossplane-system` namespaceにcrossplaneとcrossplane-rbac-managerのPodが作成されたことを確認する  
    ```
    kubectl get pods -n crossplane-system
    NAME                                      READY   STATUS    RESTARTS   AGE
    crossplane-d4cd8d784-ldcgb                1/1     Running   0          54s
    crossplane-rbac-manager-84769b574-6mw6f   1/1     Running   0          54s
    ```

3. **IAM Providerをデプロイ**  
    ```
    kubectl apply -f iam-provider.yaml
    kubectl get providers.pkg.crossplane.io
    ```
    - `upbound-provider-family-aws` provider is the family provider manages authentication to AWS across all AWS family Providers.

4. **AWS Credential、Kubernetes Secret作成**
- https://docs.crossplane.io/latest/getting-started/provider-aws/ 参照してEC2のフル権限を持つIAMユーザ/Secret Keyを作成し、Kubernetes Secretを作成する

5. **`ProviderConfig`をデプロイ**  
   ```
   kubectl apply -f providerConfig.yaml
   ```

6. **EC2インスタンスをデプロイ**  
   ```
   kubectl apply -f iam.yaml
   kugectl get User,Policy,UserPolicyAttachment
   ```  
