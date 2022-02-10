pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-raja')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t bharathirajatut/erp:1.0 .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}


		stage('Push') {

			steps {
				sh 'docker push bharathirajatut/erp:1.0'
			}
		}


		stage('Deploy to K8s')
		{
			steps{
				sshagent(['k8s'])
				{
					sh 'scp -r -o StrictHostKeyChecking=no taxiapppod-deployment.yaml centos@10.0.100.51:/home/centos'
					
					script{
						try{
							sh 'ssh centos@10.0.100.51: kubectl apply -f . '

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
