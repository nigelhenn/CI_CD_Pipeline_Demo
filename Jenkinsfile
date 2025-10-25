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
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform'],
          file(credentialsId: 'terraform-key', variable: 'TF_KEY')
        ]) {
          sh '''
            echo "Applying Terraform plan using AWS and SSH credentials..."
            export TF_VAR_private_key_path=$TF_KEY
            terraform apply -auto-approve tfplan
          '''
        }
      }
    }

    stage('Generate Ansible Inventory') {
  steps {
    withCredentials([
      file(credentialsId: 'terraform-key', variable: 'TF_KEY')
    ]) {
      sh 'terraform output -json > tf_output.json'
      script {
        def tfOutput = readJSON file: 'tf_output.json'
        def ips = tfOutput.web_instance_ips?.value ?: []
        def inventory = [
          all: [
            hosts: ips.collectEntries { ip ->
              [ (ip): [
                ansible_user: "ec2-user",
                ansible_ssh_private_key_file: env.TF_KEY
              ]]
            }
          ]
        ]
        writeFile file: 'inventory.yaml', text: groovy.json.JsonOutput.prettyPrint(groovy.json.JsonOutput.toJson(inventory))
      }
    }
  }
}


    stage('Run Ansible Playbook') {
      steps {
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform'],
          file(credentialsId: 'terraform-key', variable: 'TF_KEY')
        ]) {
          sh '''
            echo "Waiting for EC2 instances to become ready..."
            sleep 120

            # Run Ansible using generated inventory and injected SSH key
            ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini -u ec2-user --private-key "$TF_KEY" playbook.yaml
          '''
        }
      }
    }
  }
}
