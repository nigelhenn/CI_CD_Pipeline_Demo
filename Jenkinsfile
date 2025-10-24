pipeline {
  agent any

  environment {
    TF_VERSION = '1.6.0'
    TF_WORKSPACE = 'default'
    AWS_ACCESS_KEY_ID = credentials('Terraform')
    AWS_SECRET_ACCESS_KEY = credentials('Terraform')
  }
  


  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/nigelhenn/CI_CD_Pipeline_Demo.git', branch: 'main'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: 'Approve Terraform Apply?'
        sh 'terraform apply tfplan'
      }
    }
  }
}
