pipeline {
    agent any
    
    stages {
        stage('Clear Unnecessary Files') {
            steps {
                echo 'Clearing unnecessary files...'
                sh '''
                ls
                find . -type f ! -name 'Dockerfile' ! -name 'Jenkinsfile' ! -name 'docker-compose.yml' ! -name 'requirements.txt' ! -name 'start.sh' -delete
                ls
                find . -type d ! -name '.' ! -name 'resources' -exec rm -rf {} +
                ls
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
                rm -rf start.sh
                rm -rf requirements.txt
                cd ..
                mv passive_liveliness/* .
                rm -rf passive_liveliness/
                rm README.md
                '''
            }
        }

        stage('Build Image and Run Container') {
            steps {
                echo 'Building Docker image and running container...'
                // Stop any existing containers
                sh 'docker-compose down || true'
                // Build and run the container
                sh 'docker-compose up -d --build'
            }
        }
    }
}
