FROM jenkins/jenkins:lts

USER root

# Install dependencies (e.g., Terraform, Ansible, Docker CLI).
RUN apt-get update && \
    apt-get install -y curl unzip python3-pip docker.io && \
    pip3 install ansible

# Optional: install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

# Optional: install AWS CLI.
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Switch back to Jenkins user.
USER jenkins
