# Tools-SRE

**This repository contains a collection of projects that use various technologies, tools, and configurations related to the Site Reliability Engineering (SRE) role to implement and automate the Continuous Integration and Continuous Delivery (CI/CD) workflow in software development projects, following DevOps practices.**

## Included Projects

In this repository, you will find the following projects and technologies:

### CI/CD Workflows

- **[GitHub Actions](workflows/gitHub-Actions/)**: Basic workflows to implement CI/CD using *GitHub Actions.*

| Número | Proyecto | Tipo | Código |
| --- | --- | --- | --- |
| `01` | Azure App Services | CICD | [Ver](workflows/gitHub-Actions/azure-app-service.yml) |
| `02` | Azure App Services with Docker | CICD | [Ver](workflows/gitHub-Actions/azure-app-service-docker.yml) |

- **[Azure Pipelines](workflows/azure-Pipelines/)**: Advanced workflows to implement CI/CD using *Azure Pipelines.*

| Número | Proyecto | Tipo | Código |
| --- | --- | --- | --- |
| `01` | Azure App Services | CICD | [Ver](workflows/azure-Pipelines/azure-pipelines.yml) |
| `02` | Azure App Services Multistage | CICD | [Ver](workflows/azure-Pipelines/azure-multistage-pipelines.yml) |

### Docker

- **[app-dotnet](docker/app-dotnet/)**: A Dockerfile with specifications to package a *.NET* application and deployment in a local environmen with docker-compose.

- **[app-react](docker/app-react/)**: A Dockerfile with specifications to package a *React* application and deployment in a local environmen with docker-compose.

| Número | Proyecto | Tipo | Código |
| --- | --- | --- | --- |
| `01` | App ASP.NET 7 | CICD | [Ver](docker/app-dotnet/) |
| `02` | App React Vite | CICD | [Ver]() |

### Kubernetes

- **[minikube]()**: Configurations to deploy a Kubernetes infrastructure in the *On-premise and Cloud*

### Terraform

- **[Azure](terraform/)**: Configurations and scripts to deploy an *Mircosoft Azure* infrastructure.

| Número | Proyecto | Tipo | Código |
| --- | --- | --- | --- |
| `01` | Azure App Services | IaC | [Ver](terraform/az-app-services/) |

### Monitoring

- **[Monitoring Project]()**: Tools and scripts related to application and infrastructure monitoring.

## Usage Instructions

For each included project, you will find detailed instructions in their respective directories. Make sure to follow the provided guides to set up and use the tools correctly.

## Acknowledgments

Thank you for using this repository, and we hope it helps you on your journey towards effective DevOps implementation!
