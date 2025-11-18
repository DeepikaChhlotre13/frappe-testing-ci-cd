pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = "deepikachhlotre/deepika"
        TAG = "latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/DeepikaChhlotre13/frappe-testing-ci-cd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${IMAGE_NAME}:${TAG} .
                    """
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh """
                        echo "${DOCKERHUB_CREDENTIALS_PSW}" | docker login -u "${DOCKERHUB_CREDENTIALS_USR}" --password-stdin
                    """
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh """
                    docker push ${IMAGE_NAME}:${TAG}
                """
            }
        }

        /* 🚦 MANUAL APPROVAL STAGE */
        stage('Require Approval for Deployment') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input message: "Do you want to DEPLOY the new image?", ok: "Yes, Deploy"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh """
                        docker rm -f deepika-container || true

                        docker run -d \
                            --name deepika-container \
                            -p 8000:8000 \
                            ${IMAGE_NAME}:${TAG}
                    """
                }
            }
        }
    }
}


      
