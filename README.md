# 🚀 Terraform AWS E-Commerce Infrastructure

This project provisions a **highly available e-commerce architecture** on **AWS** using **Terraform**, following modern **Infrastructure as Code (IaC)** best practices.

It demonstrates **modular design**, **least-privilege security**, **idempotent deployments**, and **scalable automation**.

---

## 🧱 Architecture Overview

**AWS Services Used**

- **VPC** – Multi-AZ networking with **public** and **private subnets**, and **NAT Gateways**
- **Application Load Balancer (ALB)** – Routes traffic and handles SSL termination
- **Auto Scaling Group (ASG)** – Hosts **EC2 instances** in private subnets with automatic scaling
- **Amazon RDS** – Multi-AZ relational database for persistent storage
- **Amazon SNS** – Sends **notifications** for EC2 lifecycle and scaling events
- **Route 53** – DNS management for **`abdikarim-tech.com`**
- **S3 (Remote Backend)** – Stores **Terraform state** securely, optionally locked with **DynamoDB**
- **IAM** – Implements the **principle of least privilege**

---

## 🧩 Key Features

- 🔹 **Modular Architecture** – Each AWS component (VPC, ALB, ASG, RDS, etc.) is isolated under `/modules` for **reusability** and **maintainability**  
- 🔹 **Good Module Defaults** – Sensible defaults with flexible variables  
- 🔹 **Idempotent Deployments** – Terraform ensures safe, repeatable, drift-free changes  
- 🔹 **Least Privilege Security** – Strict IAM roles and scoped Security Groups  
- 🔹 **Scalable & Fault-Tolerant** – Multi-AZ design with ALB and ASG  
- 🔹 **Automated Notifications** – SNS triggers for EC2 behavior (e.g., scaling events)  
- 🔹 **Remote State Management** – Centralized Terraform state via S3 backend

## 📁 Project Structure

```plaintext
terraform-ecommerce-infrastructure/
├── main.tf
├── provider.tf
├── variables.tf
├── modules/
│   ├── vpc/
│   ├── security-groups/
│   ├── Database/
│   ├── alb/
│   ├── asg/
│   ├── sns/
│   └── Route53/
└── webimage.png

---



## ⚙️ How to Deploy

### Initialize & Apply
```bash
terraform init
terraform validate
terraform plan
terraform apply


## 🧠 **Highlights**

- ⚙️ **Fully Modular and Environment-Ready** – Supports multiple environments such as **`dev`**, **`staging`**, and **`prod`**
- 🔒 **Least-Privilege IAM and Networking** – Implements tight **IAM roles** and **Security Groups** to follow the **principle of least privilege**
- 🪣 **S3 Backend for Remote State** – Centralized and secure **remote state storage** with optional **DynamoDB locking** for collaboration
- 📣 **SNS Notifications** – Integrated **Amazon SNS** triggers alerts for **EC2 lifecycle events** (e.g., scaling or termination)
- 🌍 **Multi-AZ, Scalable, and Idempotent Infrastructure** – Ensures **high availability**, **fault tolerance**, and **repeatable deployments**
- 🏠 **Originally Hosted on abdikarim-tech.com** – The live infrastructure was later **decommissioned to save cost**, with screenshots preserved for reference



