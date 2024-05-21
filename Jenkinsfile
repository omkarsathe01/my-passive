pipeline {
    agent any
    
    stages {
        stage('Clear Unnecessary Files') {
            steps {
                echo 'Clearing unnecessary files...'
                sh '''
                ls -ltra
                rm -rf *
                '''
            }
        }

        stage('Clone First Repository') {
            steps {
                echo 'Cloning first repository...'
                dir('CICD-PassiveLiveliness') {
                    git branch: 'main', credentialsId: 'personal-access-token', url: 'https://github.com/rammote/CICD-PassiveLiveliness/'
                }
                sh '''
                pwd
                ls -ltra
                ls CICD-PassiveLiveliness/ -ltra
                '''
            }
        }

        stage('Clone Second Repository') {
            steps {
                echo 'Cloning second repository...'
                dir('my-passive') {
                    git branch: 'main', credentialsId: 'personal-access-token', url: 'https://github.com/omkarsathe01/my-passive/'
                }
                sh '''
                pwd
                ls -ltra
                ls my-passive/ -ltra
                '''
            }
        }

        stage('Setup') {
            steps {
                echo 'Setting up project...'
                sh '''
                # Remove start.sh and requirements.sh from CICD-PassiveLiveliness
                rm -rf CICD-PassiveLiveliness/passive_liveliness/start.sh CICD-PassiveLiveliness/passive_liveliness/requirements.sh CICD-PassiveLiveliness/passive_liveliness/.git
                rm -rf my-passive/.git

                # Move necessary files from the CICD-PassiveLiveliness to the workspace root
                mv CICD-PassiveLiveliness/passive_liveliness/* .
                
                # Move necessary files from the second repository to the workspace root
                mv my-passive/* .
                
                # Remove unnecessary files from the workspace root
                rm -rf my-passive
                rm -rf CICD-PassiveLiveliness

                ls -ltra
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
