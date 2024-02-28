pipeline {
    agent any

    stages {
        stage('Build and Package') {
            steps {
                script {
                    // Maven clean install
                    sh 'mvn clean install'
                }
            }
        }

        stage('Copy to Docker Directory') {
            steps {
                script {
                    // Copy the WAR file to the Docker directory
                    sh 'cp /var/lib/jenkins/workspace/docker-jenkins/target/docker-java-sample-webapp-1.0-SNAPSHOT.war /var/lib/jenkins/workspace/docker-jenkins/src/main/docker/'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Change to the Docker directory and build the Docker image
                    sh 'cd /var/lib/jenkins/workspace/docker-jenkins/src/main/docker/ && docker build -t tomcat:v1 .'
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Tag the Docker image
                    sh 'docker tag tomcat:v1 10.120.2.221:5000/tomcat:v1'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to the registry
                    sh 'docker push 10.120.2.221:5000/tomcat:v1'
                }
            }
        }
    }
}
