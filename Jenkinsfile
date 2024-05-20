pipeline {
    agent any
    
    stages {
        stage('Clear Preveious Files') {
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
    }
}
