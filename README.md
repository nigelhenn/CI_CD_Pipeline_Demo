🚀 Nigel Hennigar's Basic CI/CD Pipeline Demo
This project showcases a simple CI/CD pipeline built using modern DevOps tools and deployed in AWS. It was created for Kneat on Tuesday, 28th October 2025.

🛠️ Technologies Used
GitHub – Source code repository and version control

Terraform – Infrastructure as Code for provisioning AWS resources

Docker – Containerization of application components

Jenkins – Automation server for building and deploying

Ansible – Configuration management and provisioning

📦 What It Does
Provisions infrastructure in AWS using Terraform

Builds and packages application components with Docker

Automates deployment and testing via Jenkins pipelines

Configures web servers and services using Ansible

Serves a styled HTML page with Azure-inspired design

📁 File Overview
main.tf – Terraform configuration for AWS setup

Dockerfile – Container image definition

Jenkinsfile – CI/CD pipeline logic

playbook.yml – Ansible playbook for provisioning

/var/www/html/index.html – Web page served by Apache

🌐 Demo Page
The demo page is served at the root of the web server and includes:

Nigel Hennigar's Basic Pipeline demo created using GitHub, Terraform, Docker, Jenkins and Ansible in AWS for Kneat – Tuesday 28th Oct 2025

📌 Notes
Ensure AWS credentials are configured before running Terraform

Jenkins must be set up with required plugins and access to GitHub

Ansible should be run from a control node with SSH access to targets
