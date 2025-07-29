pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    ECR_REPO = '205930616561.dkr.ecr.us-east-1.amazonaws.com/flask-eks'
  }
  stages {
    stage('Checkout') {
      steps {
        git  branch:'main', url: 'https://github.com/shivaniii23/flask_eks_app.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          docker.build("flask-app")
        }
      }
    }
    stage('Push to ECR') {
      steps {
        script {
          sh '''
          aws ecr get-login-password --region $AWS_DEFAULT_REGION | echo $ECR_REPO |  docker login --username AWS --password-stdin 
          docker tag flask-app:latest $ECR_REPO:latest
          docker push $ECR_REPO:latest
          '''
        }
      }
    }
    stage('Deploy with Helm') {
      steps {
        sh 'helm upgrade --install flask-app ./charts/flask --set image.repository=$ECR_REPO,image.tag=latest'
      }
    }
  }
}
