# Intelligent Traffic Management Platform - AWS EKS Infrastructure

## Overview
This repository contains the foundational Infrastructure as Code (IaC) using Terraform to provision a secure, scalable, and highly available Amazon EKS (Elastic Kubernetes Service) environment. This infrastructure is specifically tailored to host the Intelligent Traffic Monitoring Platform, providing a robust cloud backend ready for microservices deployment and GitOps-based CI/CD automation.

## Architecture & Modules
[cite_start]The project utilizes a modular Terraform architecture to ensure code reusability and clean state management[cite: 11].

* [cite_start]**VPC Module:** Provisions a custom AWS Virtual Private Cloud (`10.0.0.0/16`) configured with both public and private subnets across multiple Availability Zones (`us-east-1a`, `us-east-1b`)[cite: 24, 64, 65, 66]. [cite_start]It includes NAT Gateways to provide secure outbound internet access for resources within private subnets[cite: 68].
* [cite_start]**EKS Module:** Deploys an Amazon EKS cluster (version 1.34) along with managed node groups utilizing `t3.medium` instances[cite: 24, 35, 38]. [cite_start]It includes advanced security configurations such as KMS encryption for Kubernetes secrets and integrated AWS CloudWatch logging for the control plane[cite: 33, 34].
* [cite_start]**IAM Module:** Configures Identity and Access Management (IAM) roles with exact least-privilege policies required for the EKS cluster and worker nodes to function securely[cite: 46, 47]. [cite_start]It also supports dynamic injection of additional IAM users and roles (such as a Jenkins role) for seamless administrative and pipeline access[cite: 25, 49].
* **Security Groups Module:** Defines strict network boundaries and firewall rules. [cite_start]It manages inbound and outbound traffic, ensuring secure communication between the EKS control plane, worker nodes, and external endpoints[cite: 52, 54].

## State Management
[cite_start]The project is configured to safely store the Terraform state remotely in an AWS S3 bucket (`devops-production-terraform`) located in the `us-east-1` region, utilizing a lock file mechanism to prevent concurrent state modifications[cite: 4].

## Prerequisites
Before you begin, ensure you have the following installed and configured:
* [cite_start][Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.0 or newer) [cite: 12]
* [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
* `kubectl` (configured to match the cluster version)

## Usage & Deployment

1.  **Clone the repository and navigate to the project directory:**
    [cite_start]Ensure you are in the root directory where `main.tf` is located[cite: 11].

2.  **Initialize Terraform:**
    This command will download the necessary AWS (`~> 5.0`) and Kubernetes (`~> 2.23`) providers and initialize the remote S3 backend[cite: 2, 3, 4].
    ```bash
    terraform init
    ```

3.  **Review the Execution Plan:**
    Verify the resources that Terraform will create. You can adjust your specific parameters (like IP allowances or instance sizing) in the `terraform.tfvars` file[cite: 24].
    ```bash
    terraform plan
    ```

4.  **Apply the Configuration:**
    Deploy the infrastructure to AWS.
    ```bash
    terraform apply
    ```

5.  **Configure `kubectl`:**
    Once the deployment is complete, Terraform will output a command to update your local kubeconfig. Run the outputted command to connect to your new cluster[cite: 21]:
    ```bash
    aws eks update-kubeconfig --region us-east-1 --name my-eks-project-dev-cluster
    ```

## Outputs
After a successful deployment, Terraform will display crucial infrastructure details including:
* [cite_start]`vpc_id` and Subnet IDs [cite: 20]
* [cite_start]`eks_cluster_endpoint` and `eks_cluster_name` [cite: 20, 21]
* [cite_start]The exact `configure_kubectl` command to authenticate with the cluster [cite: 21]

## Cleanup
To tear down the infrastructure and avoid unexpected AWS charges, run:
```bash
terraform destroy