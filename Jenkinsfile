pipeline {
    agent any

    environment {
        def gitCommit = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
        GITHUB_TOKEN = credentials('github')
    }

    stages {
        stage('Generate Unique Tag') {
            steps {
                script {
                    env.TIMESTAMP_TAG = sh(returnStdout: true, script: 'date +%Y%m%d%H%M%S').trim()
                }
            }
        }

        stage('Build image') {
            steps {
                script {
                    echo 'Pulling...' + scm.branches[0].name
                    sh "docker build -t frontend:${env.TIMESTAMP_TAG} ."
                }
            }
        }

        stage('run new version') {
            steps {
                script {
                        sh "sed -i 's|image: frontend|image: frontend:${env.TIMESTAMP_TAG}|' docker-compose.yml"
                        sh 'docker compose up -d'
                }
            }
        }
    }
}
