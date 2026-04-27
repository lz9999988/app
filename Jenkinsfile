pipeline {
    agent any

    environment {
        SWARM_STACK_NAME = 'app'
        FRONTEND_URL = 'http://192.168.0.1:8080'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Authors.name type') {
            steps {
                sh '''
                    chmod +x check_author_name_type.sh
                    ./check_author_name_type.sh
                '''
            }
        }

        stage('Build Docker Images') {
            steps {
                sh "docker build --no-cache -f php.Dockerfile -t mhnk2002/crudback1 ."
                sh "docker build --no-cache -f mysql.Dockerfile -t mhnk2002/mysql1 ."
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    if ! docker info | grep -q "Swarm: active"; then
                        docker swarm init || true
                    fi
                '''

                sh "docker stack deploy -c docker-compose.yaml ${SWARM_STACK_NAME}"
                sleep 15
            }
        }

        stage('JSON Validation Tests') {
            steps {
                sh '''
                    chmod +x tests/json_validation_test.sh
                    ./tests/json_validation_test.sh
                '''
            }
        }
    }

    post {
        success {
            echo "✔ Pipeline completed successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
        always {
            cleanWs()
        }
    }
}
