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
                    sh 'cd /var/lib/jenkins/workspace/docker-jenkins/src/main/docker/ && docker build -t 10.120.2.228:5000/tomcat:v1 .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to the registry
                    sh 'docker push 10.120.2.228:5000/tomcat:v1'
                }
            }
        }

        stage('Pull Docker Image on Test Server') {
            steps {
                script {
                    // SSH into the test server and pull the Docker image
                    sh 'ssh jenkins "docker pull 10.120.2.228:5000/tomcat:v1"'
                }
            }
        }

        stage('Execute Pre-query in MySQL') {
            steps {
                script {
                    // SSH into the test server and execute pre-query
                    sh 'ssh test@102.0.2.2 "echo \'PRE-QUERY\' > prequery.sql && mysql -uroot -proot < prequery.sql"'
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    // SSH into the test server and run Docker Compose
                    sh 'ssh test@102.0.2.2 "docker-compose up -d"'
                }
            }
        }

        stage('Execute Post-query in MySQL') {
            steps {
                script {
                    // SSH into the test server and execute post-query
                    sh 'ssh test@102.0.2.2 "echo \'POST-QUERY\' > postquery.sql && mysql -uroot -proot < postquery.sql"'
                }
            }
        }
    }
}
