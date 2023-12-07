pipeline {
    agent any
    environment {
	  PROJECT_ID = 'opensource-2023'
	  CLUSTER_NAME = 'kube'
	  LOCATION = 'asia-northeast3-a'
	  CREDENTIALS_ID = 'gkee'
    }
    stages {
        stage('Clone repository~') {
            steps {
                checkout scm
            }
        }
        stage('Check Information') {
            steps {
                sh 'pwd'
                sh 'whoami'
                sh 'ls'
                sh 'cat /etc/passwd'
                sh 'ls /home/'
                sh 'ls /var/run/'
            }
        }
        stage('Setting Docker') {
            steps {
                sh 'docker --version'
            }
        }
        stage('Build Image~') {
            steps {
                script {
                    app = docker.build("yangsubinn/opensource-2023")
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'yangsubin') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy to GKE') {
            when {
			branch 'master'
            }
            steps {
			sh "sed -i 's/yangsubinn:latest/opensource-2023:${env.BUILD_ID}/g' deployment.yaml"
			step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }
}
