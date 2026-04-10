pipeline {
    agent any

    stages {

        stage("Clone code") {
            steps {
                echo "Cloning repository..."
                git branch: 'dev',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/404bad/pokemon.git'
            }
        }

        stage("Build Docker image") {
            steps {
                echo "Building Docker image..."
                sh "docker build -t pokemon-app ."
            }
        }

        stage("Push Docker image to Docker Hub") {
            steps {
                echo "Pushing image to Docker Hub..."
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "docker tag pokemon-app ${env.DOCKER_USER}/pokemon-app:dev"
                    sh "docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_PASS}"
                    sh "docker push ${env.DOCKER_USER}/pokemon-app:dev"
                }
            }
        }

        stage("SSH into deployment server") {
            steps {
                sshagent(['ssh']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@52.62.134.27 'cd pokemon-app && docker compose up --force-recreate -d'"
                }
            }
        }

    }

    post {
        success {
            echo "Deployment successful — app is live!"
        }
        failure {
            echo "Pipeline failed — check the stage logs above."
        }
    }
}