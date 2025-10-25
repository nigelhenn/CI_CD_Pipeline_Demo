pipeline {
  agent any

  environment {
    TF_VERSION = '1.6.0'
    TF_WORKSPACE = 'default'
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/nigelhenn/CI_CD_Pipeline_Demo.git', branch: 'main'
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform']]) {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform']]) {
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform']]) {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: 'Approve Terraform Apply?'
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform']]) {
          sh 'terraform apply -auto-approve tfplan'
        }
      }
    }

    stage('Run Ansible Playbook') {
      steps {
        // Use both AWS and Ansible credentials
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform'],
          file(credentialsId: 'terraform-key', variable: 'TF_KEY')
        ]) {
          sh '''
            echo "Waiting for EC2 instances to become ready..."
            sleep 120

            # Ensure jq is available (some agents may not have it)
            if ! command -v jq &>/dev/null; then
              echo "jq not found — installing..."
              sudo apt-get update && sudo apt-get install -y jq
            fi

            # Extract instance IPs
            IPS=$(terraform output -json | jq -r '.web[*].public_ip')
            echo "Discovered EC2 IPs: $IPS"

            # Run Ansible playbook against each instance
            for ip in $IPS; do
              echo "Running Ansible on $ip..."
              ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i "$ip," -u ec2-user --private-key $TF_KEY playbook.yaml
            done
          '''
        }
      }
    }
  }
}
