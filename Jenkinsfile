pipeline {
    agent any
    
    stages {
        stage('Pull Image') {
            steps {
                echo "Pulling.."
                bat 'docker pull mightysanjay/my-passive:v1'
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
