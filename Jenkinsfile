pipeline {
    agent any
    environment { 
        GITHUB_TOKEN = credentials('255da05b-0379-4ab0-a77c-2b07fb6c7b8c')  
        DOCKER_IMAGE_NAME_1 = 'shahdabdulaziz/weather-app-image'
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
                        sh 'git clone https://$GITHUB_TOKEN@github.com/ShahdMenaisy/Weather-app weather-app'
                    }
                }
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: '9bacbeb1-3729-47ba-8c5b-fb3957c3db45', variable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u shahdabdulaziz --password-stdin'
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
                chmod 600 keys/private_key1
                chmod 600 keys/private_key2
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