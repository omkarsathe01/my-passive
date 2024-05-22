pipeline {
    agent any
    
    environment {
        GIT_CREDENTIALS = 'personal-access-token'
    }
    
    stages {
        stage('Clear Unnecessary Files') {
            steps {
                echo 'Clearing unnecessary files...'
                bat 'dir'
                bat 'del /Q *'
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
                bat '''
                REM Clean up repositories
                del /Q /F CICD-PassiveLiveliness\\passive_liveliness\\start.sh
                del /Q /F CICD-PassiveLiveliness\\passive_liveliness\\wsgi.py
                del /Q /F CICD-PassiveLiveliness\\passive_liveliness\\requirements.sh
                rmdir /S /Q CICD-PassiveLiveliness\\.git
                rmdir /S /Q my-passive\\.git

                REM Move necessary files to workspace root
                move CICD-PassiveLiveliness\\passive_liveliness\\* .
                move my-passive\\* .

                REM Remove repositories directories
                rmdir /S /Q CICD-PassiveLiveliness
                rmdir /S /Q my-passive

                REM List files for verification
                dir
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker-compose build'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                bat 'docker-compose up -d'
            }
        }
    }
}
