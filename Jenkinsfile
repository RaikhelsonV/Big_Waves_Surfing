pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git', url: 'https://github.com/RaikhelsonV/Big_Waves_Surfing.git']])
            }
        }
        stage('Determine Docker Image Tag') {
            steps {
                script {
                    // Get the short SHA of the latest commit
                    def gitSha = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()

                    // Set the Docker image tag as the short SHA
                    env.DOCKER_IMAGE_TAG = gitSha
                }
            }
        }
        stage('Docker Build') {
            steps {
               sh 'docker build -t raikhelson/big_waves_surfing:${DOCKER_IMAGE_TAG} .'
            }
        }  
        stage('Docker Push') {
            steps {
               withCredentials([string(credentialsId: 'DockerHub', variable: 'DockerHub')]) {
                    sh 'docker login -u raikhelson -p ${DockerHub}'
                }
                sh 'docker push raikhelson/big_waves_surfing:${DOCKER_IMAGE_TAG}'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([kubeconfigFile(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
                        sh "kubectl apply -f kubernetes.yaml"
            }
        }
    }
    }
}
