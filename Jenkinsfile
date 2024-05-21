pipeline {
    agent any
    
    stages {
        stage('Clear Unnecessary Files') {
            steps {
                echo 'Clearing unnecessary files...'
                sh '''
                find . -type f ! -name 'Dockerfile' ! -name 'Jenkinsfile' ! -name 'docker-compose.yml' ! -name 'requirements.txt' ! -name 'start.sh' -delete
                find . -type d ! -name '.' ! -name 'resources' -exec rm -rf {} +
                '''
            }
        }
        
        stage('Clone PassiveLiveliness') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', credentialsId: 'personal-access-token', url: 'https://github.com/rammote/CICD-PassiveLiveliness/'
            }
        }

        stage('PassiveLiveliness Setup') {
            steps {
                echo 'Setting up PassiveLiveliness...'
                sh '''
                cd passive_liveliness/
                rm -rf start.sh requirements.txt
                mv * ..
                cd ..
                rm -rf passive_liveliness/
                '''
            }
        }

        stage('Build Image and Run Container') {
            steps {
                echo 'Building Docker image and running container...'
                sh 'pwd'
                sh 'ls'
                // Stop any existing containers
                sh 'docker-compose down || true'
                // Build and run the container
                sh 'docker-compose up -d --build'
            }
        }
    }
}
