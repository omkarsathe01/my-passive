pipeline {
    agent any
    
    stages {
        stage('Clear Unnecessary Files') {
            steps {
                echo 'Clearing unnecessary files...'
                sh '''
                ls -ltra
                // find . -type f ! -name 'Dockerfile' ! -name 'Jenkinsfile' ! -name 'docker-compose.yml' ! -name 'requirements.txt' ! -name 'start.sh' -delete
                // ls
                // find . -type d ! -name '.' ! -name 'resources' -exec rm -rf {} +
                ls
                '''
            }
        }

        stage('Clone First Repository') {
            steps {
                echo 'Cloning first repository...'
                dir('repo1') {
                    git branch: 'main', credentialsId: 'personal-access-token', url: 'https://github.com/rammote/CICD-PassiveLiveliness/'
                }
            }
        }

        stage('Clone Second Repository') {
            steps {
                echo 'Cloning second repository...'
                dir('repo2') {
                    git branch: 'main', credentialsId: 'personal-access-token', url: 'https://github.com/yourusername/yourprojectrepo/'
                }
            }
        }

        stage('Setup') {
            steps {
                echo 'Setting up project...'
                sh '''
                # Move necessary files from the second repository to the workspace root
                mv repo2/* .
                
                # Remove unnecessary files from the workspace root
                rm -rf repo2
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
