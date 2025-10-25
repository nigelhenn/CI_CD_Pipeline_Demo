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
          sh 'terraform apply tfplan'
        }
      }
    }
  }
}
