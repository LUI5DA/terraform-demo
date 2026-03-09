# Terraform + Ansible Azure Demo (Tetris Deployment)

This project demonstrates a simple **Infrastructure as Code (IaC)** workflow using **Terraform** and **Ansible** to provision and configure a cloud environment.

The goal of the project is to:

1. Provision infrastructure in **Microsoft Azure** using **Terraform**.
2. Configure the created virtual machine using **Ansible**.
3. Deploy a simple web application (a Tetris game) served through **NGINX**.

The entire workflow runs **locally**, meaning Terraform and Ansible are executed from the developer machine.

---

# Architecture Overview

The project follows a typical DevOps flow:

```
Local Machine
     │
     │ Terraform
     ▼
Azure Infrastructure
     │
     │ Ansible
     ▼
Configured VM with NGINX
     │
     ▼
Tetris Web Application
```

### Workflow

1. **Terraform**

   * Creates Azure infrastructure.
   * Provisions networking and a Linux Virtual Machine.

2. **Ansible**

   * Connects to the created VM through SSH.
   * Installs and configures NGINX.
   * Deploys the web application.

---

# Technologies Used

## Terraform

Terraform is used to **provision infrastructure declaratively**.

In this project Terraform creates:

* Azure Resource Group
* Virtual Network
* Subnet
* Network Security Group
* Public IP
* Network Interface
* Linux Virtual Machine

Terraform allows infrastructure to be defined as code, making it reproducible, version-controlled, and easy to maintain.

Key benefits:

* Infrastructure versioning
* Idempotent infrastructure provisioning
* Cloud provider abstraction
* Automated environment setup

---

## Ansible

Ansible is used for **configuration management**.

Once Terraform provisions the VM, Ansible:

* Connects to the machine via SSH
* Installs required software
* Configures the web server
* Deploys the application

Unlike Terraform, which focuses on **infrastructure provisioning**, Ansible focuses on **system configuration and application deployment**.

Key benefits:

* Agentless architecture
* YAML-based playbooks
* Idempotent configuration
* Simple SSH-based communication

---

# Project Structure

```
terraform-demo
│
├── terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
│
├── ansible
│   ├── ansible.cfg
│   ├── inventory.yaml
│   └── playbook.yaml
│
├── app
│   └── index.html
│
└── README.md
```

### terraform/

Contains all Terraform configuration files used to create the Azure infrastructure.

### ansible/

Contains the Ansible configuration and playbook used to configure the VM and deploy the application.

### app/

Contains the web application that will be deployed to the server.

---

# Prerequisites

Before running the project, make sure you have the following installed:

### Terraform

Install Terraform:

https://developer.hashicorp.com/terraform/downloads

Verify installation:

```bash
terraform -version
```

---

### Ansible

Install Ansible:

```bash
sudo dnf install ansible
```

Verify installation:

```bash
ansible --version
```

---

### Azure CLI

Install Azure CLI:

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

Login to Azure:

```bash
az login
```

---

# Authentication Setup

Terraform authenticates with Azure using environment variables.

Export the following variables:

```bash
export ARM_CLIENT_ID="your-client-id"
export ARM_CLIENT_SECRET="your-client-secret"
export ARM_TENANT_ID="your-tenant-id"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
```

These credentials correspond to an **Azure Service Principal** with appropriate permissions.

---

# Terraform Setup

Navigate to the Terraform directory:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Plan the infrastructure:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

Terraform will create the Azure resources and output the **public IP address of the virtual machine**.

Example output:

```
public_ip = 20.xxx.xxx.xxx
```

This IP will be used by Ansible to configure the machine.

---

# Ansible Configuration

Navigate to the Ansible directory:

```bash
cd ansible
```

Edit the inventory file and set the VM public IP:

```yaml
all:
  children:
    web:
      hosts:
        tetris-vm:
          ansible_host: YOUR_PUBLIC_IP
          ansible_user: azureuser
          ansible_ssh_private_key_file: ~/.ssh/tetris-demo
```

Replace:

```
YOUR_PUBLIC_IP
```

with the public IP returned by Terraform.

---

# Running the Ansible Playbook

Execute the playbook:

```bash
ansible-playbook playbook.yaml
```

The playbook will:

1. Connect to the VM
2. Install NGINX
3. Configure the web server
4. Deploy the Tetris application

---

# Accessing the Application

Once Ansible finishes, open a browser and navigate to:

```
http://<VM_PUBLIC_IP>
```

You should see the **Tetris game running on the server**.

---

# What This Project Demonstrates

This project demonstrates a simplified DevOps workflow using Infrastructure as Code tools.

Key concepts illustrated:

* Infrastructure provisioning with Terraform
* Configuration management with Ansible
* Separation of infrastructure and application configuration
* Automated server setup
* Reproducible cloud environments

---

# Possible Improvements

Some improvements that could be added:

* Automated inventory generation from Terraform outputs
* CI/CD integration using GitHub Actions
* Containerized deployment
* Infrastructure modularization
* Secret management with Azure Key Vault

---

# License

This project is provided for educational purposes and demonstration of Infrastructure as Code practices.

