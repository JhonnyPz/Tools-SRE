# Tools-SRE

**This repository contains a collection of projects that use various technologies, tools, and configurations related to the Site Reliability Engineering (SRE) role to implement and automate the Continuous Integration and Continuous Delivery (CI/CD) workflow in software development projects, following DevOps practices.**

## Included Projects

In this repository, you will find the following projects and technologies:


## CI/CD Workflows

- **[GitHub Actions](workflows/gitHub-Actions/)**: Basic workflows to implement CI/CD using *GitHub Actions.*

| Number | Project | Type | Code |
| --- | --- | --- | --- |
| `01` | Azure App Services | CICD | [Ver](workflows/gitHub-Actions/azure-app-service.yml) |
| `02` | Azure App Services with Docker | CICD | [Ver](workflows/gitHub-Actions/azure-app-service-docker.yml) |


- **[Azure Pipelines](workflows/azure-Pipelines/)**: Advanced workflows to implement CI/CD using *Azure Pipelines.*

| Number | Project | Type | Code |
| --- | --- | --- | --- |
| `01` | Azure App Services | CICD | [Ver](workflows/azure-Pipelines/azure-pipelines.yml) |
| `02` | Azure App Services Multistage | CICD | [Ver](workflows/azure-Pipelines/azure-multistage.yml) |
| `03` | Azure App Services Docker | CICD | [Ver](workflows/azure-Pipelines/azure-docker.yml) |
| `04` | Azure Kubernetes Service | CICD | [Ver](workflows/azure-Pipelines/azure-kubernetes.yml) |
| `M01` | Module Build | CI| [Ver](workflows/azure-Pipelines/modules/build.yml) |
| `M02` | Module Deploy | CD | [Ver](workflows/azure-Pipelines/modules/deploy.yml) |
| `M03` | Module Unit Tests | CD | [Ver](workflows/azure-Pipelines/modules/unit-test.yml) |
| `M04` | Module Load Tests | CD | [Ver](workflows/azure-Pipelines/modules/load-test.yml) |
| `M05` | Module Functions | CD | [Ver](workflows/azure-Pipelines/modules/functions.yml) |


## Docker

- **[Dockerfile & Compose](docker/)**: Dockerfile

| Number | Project | Type | Code |
| --- | --- | --- | --- |
| `01` | App ASP.NET 7 | IMG | [Ver](docker/app-dotnet/) |
| `02` | App React Vite | IMG | [Ver]() |


## Kubernetes

- **[Kubernetes On-premises](kubernetes/)**: Manifest files are needed to deploy a Kubernetes infrastructure on-premises.


## Terraform

- **[Azure](terraform/)**: Configurations and scripts to deploy an *Mircosoft Azure* infrastructure.

| Number | Project | Type | Code |
| --- | --- | --- | --- |
| `01` | Azure Virtual Machine Linux | IaC | [Ver](terraform/az-vm-linux/) |
| `01.1` | Azure Virtual Machine Minikube | IaC | [Ver](terraform/az-vm-minikube/) |
| `02` | Azure App Services | IaC | [Ver](terraform/az-app-services/) |
| `03` | Azure App Functions | IaC | [Ver](terraform/az-app-functions/) |
| `04` | Azure Container Registry | IaC | [Ver](terraform/az-container-registry/) |
| `05` | Azure Kubernetes Services | IaC | [Ver](terraform/az-kubernetes-services/) |


## Monitoring

- **[Monitoring Project]()**: Tools and scripts related to application and infrastructure monitoring.


## Usage Instructions

For each included project, you will find detailed instructions in their respective directories. Make sure to follow the provided guides to set up and use the tools correctly.

## Acknowledgments

Thank you for using this repository, and we hope it helps you on your journey towards effective DevOps implementation!
