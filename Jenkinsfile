pipeline {
    agent any
    
    stages {
        stage('Pull Image') {
            steps {
                echo "Pulling.."
                bat 'docker pull mightysanjay/my-passive:v1'
            }
        }

        stage('Clone Repository') {
            steps {
                echo "Cloning.."
                git url:'https://github.com/omkarsathe01/my-passive.git', branch:'main'
            }
        }

        stage('Run Image') {
            steps {
                echo "Running.."
                bat 'docker compose up -d'
            }
        }
    }
}
