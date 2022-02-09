pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('valaxytech-dockerhub')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://gitlab.com/arsravis/taxigrabber.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t valaxytech/taxigrabber:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push valaxytech/taxigrabber:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}





    
        
        
