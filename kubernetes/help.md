# Command Kubernetes

## Basic Commands (Beginner):
- create deployment name --image=name
- expose name --port 80 --target-port 80 --type NodePort
- run name --image=name
- set image deployment name app=nginx:1.24-alpine

## Basic Commands (Intermediate):
- get nodes -o wide
- get pods -w
- get service
- get deploment
- get namespace
- edit deployment name
- delete deployment name

## Deploy Commands:
- kubectl apply -f name.yml
- scale deployment name --replicas=3
- rollout undo deployment name

## Troubleshooting and Debugging Commands:
- describe pod name
- logs -f -l app=name
- exec -it name -- /bin/bash
- port-forward --address 0.0.0.0 svc/name 8080:80

## Secret And ConfigMap
-  create configmap name --from-file=/path/
- create secret name 

## Usage:
- kubectl [flags] [options]