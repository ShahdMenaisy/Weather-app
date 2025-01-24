pipeline {
    agent any
    environment { 
        GITHUB_TOKEN = credentials('<GITHUB_TOKEN_CREDENTIALS_ID>')  
        DOCKER_IMAGE_NAME_1 = '<DOCKER_IMAGE_NAME>'
    }

    stages {
        stage('Fetch-Code') {
            steps {
                script {
                    if (fileExists('weather-app/.git')) {
                        echo "Repository exists. Performing git pull..."
                        sh 'cd weather-app && git pull'
                    } else {
                        echo "Repository doesn't exist. Performing git clone..."
                        sh 'git clone https://$GITHUB_TOKEN@github.com/<USERNAME>/<REPO> weather-app'
                    }
                }
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: '<DOCKER_PASSWORD_CREDENTIALS_ID>', variable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u <DOCKER_USERNAME> --password-stdin'
                    }
                }
            }
        }

        stage('Image Build') {
            steps {
                sh '''
                cd weather-app
                docker build --tag $DOCKER_IMAGE_NAME_1 .
                '''
            }
        }

        stage('Push image to Docker Hub') {
            steps {
                sh 'docker push $DOCKER_IMAGE_NAME_1'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                sh '''
                cd weather-app
                chmod 600 keys/<PRIVATE_KEY_1>
                chmod 600 keys/<PRIVATE_KEY_2>
                ansible-playbook -i inventory playbook.yml
                '''
            }
        }
    }

    /*post {
        always {
            sh 'rm -rf ./*'
        }
    }*/
}
