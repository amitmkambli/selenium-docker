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
                bat "docker build -t amitdocker369/selenium ."
            }            
        }  

        stage('Push image'){
            steps{
                bat "docker push amitdocker369/selenium"
            }            
        }                

    }

}