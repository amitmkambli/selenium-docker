pipeline{

    agent any

    stages{

        stage('Build jar'){
            steps{
                bat "mvn clean package -DskipTests"
            }
        }

        stage('Build image'){
            steps{
                bat "docker build -t amitdocker369/selenium:latest ."
            }            
        }  

        stage('Push image'){
            environment{
                DOCKER_HUB = credentials('dockerhub-creds')
            }
            steps{
                bat 'docker login -u %DOCKER_HUB_USR% -p %DOCKER_HUB_PSW%'
                // bat 'echo %DOCKER_HUB_PSW% | docker login -u %DOCKER_HUB_USR% --password-stdin'
                bat "docker push amitdocker369/selenium:latest"
                bat "docker tag amitdocker369/selenium:latest amitdocker369/selenium:latest${env.BUILD_NUMBER}"
                bat "docker push amitdocker369/selenium:${env.BUILD_NUMBER}"
            }            
        }    

    }
    post{
            always{
                bat "docker logout"
            }
        }

}