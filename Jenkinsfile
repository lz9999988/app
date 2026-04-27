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

        stage('Load DB schema from dump') {
            steps {
                sh '''
                    POD=$(kubectl get pods -o name | grep '^pod/mysql-' | head -n1 | cut -d/ -f2)

                    if [ -z "$POD" ]; then
                        echo "ERROR: MySQL pod not found"
                        exit 1
                    fi

                    echo "Using MySQL pod: $POD"

                    kubectl exec -i $POD -- mysql -u root -psecret -e "DROP DATABASE IF EXISTS dbook; CREATE DATABASE dbook CHARACTER SET utf8 COLLATE utf8_general_ci;"

                    kubectl exec -i $POD -- mysql -u root -psecret dbook < dump/dbook.sql
                '''
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
