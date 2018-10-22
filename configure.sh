kubectl apply -f admin-user-cluster-role-binding.yaml
kubectl apply -f admin-user-service-account.yaml
helm init --service-account=admin-user
helm repo update
helm install --name cert-manager --namespace kube-system stable/cert-manager
kubectl apply -f srtsignin-namespaces.yaml
kubectl create secret generic srtsignin-role-secret --from-file=./secrets/auth-keys.properties
kubectl create secret generic srtsignin-cardfire-secret --from-file=./secrets/secrets-cf.properties
kubectl create secret generic srtsignin-active-users-secret --from-file=./secrets/active-users-config.json
kubectl create secret generic srtsignin-role-secret -n stage --from-file=./stage-secrets/auth-keys.properties
kubectl create secret generic srtsignin-cardfire-secret -n stage --from-file=./stage-secrets/secrets-cf.properties
kubectl create secret generic srtsignin-active-users-secret -n stage --from-file=./stage-secrets/active-users-config.json
kubectl apply -f .