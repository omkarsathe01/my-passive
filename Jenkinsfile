pipeline {
    agent any
    
    stages {
        stage('Clear Previous Files') {
            steps {
                sh '''
                rm -rf *
                '''
            }
        }
        
        stage('Clone PassiveLiveliness') {
            steps {
                echo "Cloning.."
                git branch: 'main', credentialsId: 'personal-access-token', url: 'https://github.com/rammote/CICD-PassiveLiveliness/'
            }
        }

        stage('PassiveLiveliness Setup') {
            steps {
                sh '''
                cd passive_liveliness/
                rm -rf start.sh
                rm -rf requirements.txt
                cd ..
                mv passive_liveliness/* .
                rm -rf passive_liveliness/
                rm README.md
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("CICD-PassiveLiveliness:latest")
                }
            }
        }
        
        stage('Run Container') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}