```sh
alias k=kubectl

k create ns dev
k config set-context --current --namespace=dev

k apply -f kubernetes/db-volume.yml
k apply -f kubernetes/db-secret.yml
k apply -f kubernetes/db-deployment.yml

docker build -t jhonnypz/app:dev .
docker pull jhonnypz/app:dev

kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>

k apply -f kubernetes/app-configmap.yml
k apply -f kubernetes/app-secret.yml
k apply -f kubernetes/app-deployment.yml

k port-forward --address 0.0.0.0 svc/app 8080:80
```