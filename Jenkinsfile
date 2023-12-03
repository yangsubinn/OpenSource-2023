node {
	def app
	stage('Clone repository') {
		git 'https://github.com/yangsubinn/OpenSource-2023.git'
	}
	stage('Build Image') {
		app = docker.build("yangsubinn/opensource-2023")
	}
	stage('Test Image') {
		app.inside {
			sh 'make test'
		}
	}
	stage('Push Image') {
		docker.withRegistry('https://registry.hub.docker.com', 'yangsubin') {
			app.push("${env.BUILD_NUMBER}")
			app.push("latest")
		}
	}
}
