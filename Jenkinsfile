pipeline {
    agent any
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
		sh 'usermod -aG docker \${USER}'
		sh 'systemctl restart docker'
            }
	}
        stage('Build Image~') {
            steps {
                script {
                    docker.build("yangsubinn/opensource-2023").inside {
                        sh 'make test'
                    }
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
    }
}
