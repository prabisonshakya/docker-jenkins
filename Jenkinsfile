pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Perform SonarQube analysis using Maven
                    def mvn = tool 'Default Maven';
                    withSonarQubeEnv() {
                        sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=jenkins"
                    }
                }
            }
        }

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

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to the registry
                    sh 'docker push 10.120.2.223:5000/tomcat:v1'
                }
            }
        }
    }
}
