**Getting Started**

This guide will walk you through deploying infrastructure using Terraform while following Infrastructure as Code (IaC) practices. The provided project structure includes various modules for deploying resources in Microsoft Azure, demonstrating best practices for managing and automating your cloud infrastructure.

## Prerequisites

Before you begin, ensure you have the following:

- Terraform installed: [Install Terraform](https://www.terraform.io/downloads.html)
- An [Azure subscription](https://azure.microsoft.com/en-in/pricing/free-services/) with valid credentials
- Basic familiarity with Terraform concepts and Azure services

## Project Structure

```
terraform
├── az-vm-linux
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── az-vm-minikube
│   ├── main.tf
│   ├── ...
├── az-app-services
│   ├── main.tf
│   ├── ...
├── az-app-functions
│   ├── main.tf
│   ├── ...
├── az-container-registry
│   ├── main.tf
│   ├── ...
```

The project is organized into different directories, each representing a module for deploying specific Azure resources.

## Instructions

### **Terraform Deployment Steps**

1. **Choose a Module**:

   Select the module that corresponds to the type of Azure resources you want to deploy. For example, if you want to deploy a Linux Virtual Machine, navigate to the `az-vm-linux` directory.

2. **Define Variables**:

   Open the `variables.tf` file and set the required variables for your deployment. These variables will be used in your Terraform configuration to customize your resource deployment.

3. **Configure the Main Configuration**:

   Open the `main.tf` file. This is where you define your Terraform configuration using the Azure provider and the resources you want to deploy. Customize the configuration based on your requirements.

4. **Outputs and Dependencies**:

   In the `outputs.tf` file, define any outputs you want to capture from the deployed resources. These outputs can be useful for other parts of your infrastructure or for reference.

5. **Initialize and Deploy**:

   In the terminal, navigate to the module directory and run the following commands:

   ```sh
   terraform init
   terraform plan
   terraform apply
   ```

   These commands will initialize Terraform, show you a plan of what will be deployed, and then apply the changes to your Azure subscription.

6. **Destroy Resources (if needed)**:

   If you want to remove the resources you deployed, you can use the following command:

   ```sh
   terraform destroy
   ```

   Be cautious when using this command, as it will permanently delete the resources.

## Conclusion

By following this guide, you've successfully set up a project structure for deploying Azure resources using Terraform and practicing Infrastructure as Code. This approach provides automation, version control, and consistency to your infrastructure deployments.

Feel free to explore and customize each module's configuration files to match your project's specific requirements. Refer to the official Terraform documentation for more advanced usage and in-depth explanations of Terraform concepts.

Happy infrastructure provisioning and automation! 🏗️