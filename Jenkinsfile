pipeline {
    agent any
    
    environment {
        GIT_CREDENTIALS = 'personal-access-token'
    }
    
    stages {
        stage('Clear Unnecessary Files') {
            steps {
                echo 'Clearing unnecessary files...'
                sh 'rm -rf *'
            }
        }

        stage('Clone Repositories') {
            parallel {
                stage('Clone First Repository') {
                    steps {
                        echo 'Cloning first repository...'
                        dir('CICD-PassiveLiveliness') {
                            git branch: 'main', credentialsId: env.GIT_CREDENTIALS, url: 'https://github.com/rammote/CICD-PassiveLiveliness/'
                        }
                    }
                }
                stage('Clone Second Repository') {
                    steps {
                        echo 'Cloning second repository...'
                        dir('my-passive') {
                            git branch: 'main', credentialsId: env.GIT_CREDENTIALS, url: 'https://github.com/omkarsathe01/my-passive/'
                        }
                    }
                }
            }
        }

        stage('Setup') {
            steps {
                echo 'Setting up project...'
                sh '''
                # Clean up repositories
                rm -rf CICD-PassiveLiveliness/passive_liveliness/start.sh CICD-PassiveLiveliness/passive_liveliness/requirements.sh CICD-PassiveLiveliness/passive_liveliness/.git
                rm -rf my-passive/.git

                # Move necessary files to workspace root
                mv CICD-PassiveLiveliness/passive_liveliness/* .
                mv my-passive/* .

                # Remove repositories directories
                rm -rf CICD-PassiveLiveliness my-passive

                # List files for verification
                ls -ltra
                '''
            }
        }

        stage('Build Image and Run Container') {
            steps {
                echo 'Building Docker image and running container...'
                sh 'docker-compose up --build -d app'
            }
        }
    }
}
