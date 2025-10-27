# 🚀 Basic CI/CD Pipeline Demo

This project showcases a simple yet complete **CI/CD pipeline** built using modern DevOps tools and deployed on **AWS**.  
It was created for **Kneat Solutions** on **Saturday, 25th October 2025**.

---

## 🛠️ Technologies Used

| Tool | Purpose |
|------|----------|
| **GitHub** | Source code management and version control |
| **Terraform** | Infrastructure as Code (IaC) for provisioning AWS resources |
| **Docker** | Containerized Jenkins instance |
| **Jenkins** | Automation server for build, test, and deployment pipelines |
| **Ansible** | Configuration management and post-provisioning setup |

---

## 📦 What It Does

This pipeline demonstrates a full CI/CD workflow:

- 🚀 **Provision infrastructure** in AWS using Terraform  
- 🧱 **Build and package** application components with Docker  
- ⚙️ **Automate deployment and testing** using Jenkins pipelines  
- 🧩 **Configure servers and services** via Ansible  
- 🌐 **Serve a styled HTML page** inspired by AWS’s design aesthetic  

---

## 📁 File Overview

| File | Description |
|------|--------------|
| `main.tf` | Terraform configuration for AWS EC2 instance provisioning |
| `Dockerfile` | Jenkins container image definition |
| `Jenkinsfile` | Jenkins pipeline logic for build, plan, apply, and deploy stages |
| `playbook.yml` | Ansible playbook for configuring EC2 instances |
| `/var/www/html/index.html` | Static web page served by Apache |

---

## 🌐 Demo Page

The demo web page (served at the root of the deployed web server) includes:

> *Basic Pipeline demo created using GitHub, Terraform, Docker, Jenkins, and Ansible in AWS for Kneat – Tuesday, 28th October 2025.*

---

## 📌 Important Notes

- ✅ **AWS Credentials** must be configured in Jenkins or environment variables before running Terraform  
- 🧩 **Jenkins** must have required plugins installed and access to the GitHub repository  
- ⚠️ **Jenkins Job Name** should contain **no spaces**  
- 🔐 **Ansible** must be installed on the Jenkins control node with SSH access to target instances  
- 🗝️ **SSH keys** for Ansible are stored in the Jenkins Credentials Manager  
- 🧮 **Dynamic Ansible Inventory** is generated during Jenkins pipeline stages  

---

## 💡 Summary

This demo integrates **Infrastructure as Code**, **automation**, and **configuration management** into a cohesive CI/CD workflow — showcasing how to go from source code to a deployed and configured environment in AWS using entirely open-source DevOps tooling.

---

**Created by:** [Nigel H](#)  
**Date:** Saturday, 25th October 2025  
**For:** Kneat Solutions