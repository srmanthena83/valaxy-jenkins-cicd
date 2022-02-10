pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('sreemanthena-dockerhub')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/srmanthena83/valaxy-jenkins-cicd.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t sreemanthena/taxiappgrabber:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push sreemanthena/taxiappgrabber:$BUILD_NUMBER'
            }
        }
        stage('Create POD on K8s')
		{
			steps{
				sshagent(['k8s'])
				{
					sh 'scp -r -o StrictHostKeyChecking=no taxiapppod-deployment.yaml centos@10.0.100.51:/var/tmp/'
					
					script{
						try{
							sh 'ssh centos@10.0.100.51 kubectl apply -f /var/tmp/taxiapppod-deployment.yaml'

							}catch(error)
							{

							}
					}
				}
			}
		}
}
post {
        always {
            sh 'docker logout'
        }
    }
}
