# 目的
- KyvernoをAdmission Cotrollerとして、CrossPlaneからのAWSリソースのガバナンスを効かせる動きを試す

> [!NOTE]  
> ##### Admission Cotrollerについて
> - https://kyverno.io/docs/introduction/admission-controllers/

## Kyverno install
- https://kyverno.io/docs/installation/methods/  
  ```shell
  helm repo add kyverno https://kyverno.github.io/kyverno/
  helm repo update
  helm install kyverno kyverno/kyverno -n kyverno --create-namespace
  ```
  - `kyverno` namespace上に以下4つのPodが作成される
    - `kyverno-admission-controller`
    - `kyverno-background-controller`
    - `kyverno-cleanup-controller`
    - `kyverno-reports-controller`

## 動作確認
- 本リポジトリにある`ec2-t2micro-only-rule.yaml`をデプロイする
  - `kubectl apply -f ec2-t2micro-only-rule.yaml`
- crossplaneディレクトリ上の`ec2.yaml`を`kubectl apply -f`でデプロイし、以下のようにエラーになることを確認  
  ```shell
  Error from server: error when creating "ec2.yaml": admission webhook "validate.kyverno.svc-fail" denied the request:

  resource Instance//test2 was blocked due to the following policies

  instance-t2.mirco-allow-only:
    instance-t2.micro-allow-only: 'validation error: Using any instance type other than
      `t2.micro` is not allowed. rule instance-t2.micro-allow-only failed at path /spec/forProvider/instanceType/'
  ```