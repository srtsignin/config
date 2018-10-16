kubectl apply -f admin-user-cluster-role-binding.yaml
kubectl apply -f admin-user-service-account.yaml
helm init --service-account=admin-user
helm repo update
helm install --name cert-manager --namespace kube-system stable/cert-manager
kubectl create secret generic srtsignin-role-secret --from-file=./auth-keys.properties
kubectl create secret generic srtsignin-cardfire-secret --from-file=./secrets-cf.properties
kubectl apply -f .