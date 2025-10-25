pipeline {
  agent any

  environment {
    TF_VERSION = '1.6.0'
    TF_WORKSPACE = 'default'
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/nigelhenn/Terraform-Build.git', branch: 'main'
      }
    }

    stage('Terraform Init / Plan / Apply') {
      steps {
        withCredentials([
          // AWS credentials stored in Jenkins as "Terraform"
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'Terraform'],
          // PEM private key file stored in Jenkins as "terraform-key"
          file(credentialsId: 'terraform-key', variable: 'TF_PRIVATE_KEY')
        ]) {
          sh '''
            terraform init

            terraform validate \
              -var "aws_access_key_id=$AWS_ACCESS_KEY_ID" \
              -var "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" \
              -var "private_key_path=$TF_PRIVATE_KEY"

            terraform plan -out=tfplan \
              -var "aws_access_key_id=$AWS_ACCESS_KEY_ID" \
              -var "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" \
              -var "private_key_path=$TF_PRIVATE_KEY"

            # Optional: Require manual approval
            terraform apply -auto-approve tfplan \
              -var "aws_access_key_id=$AWS_ACCESS_KEY_ID" \
              -var "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" \
              -var "private_key_path=$TF_PRIVATE_KEY"
          '''
        }
      }
    }
  }
}