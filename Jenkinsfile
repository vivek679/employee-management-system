pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "3.9.6"
    }

    stages {
        stage('preparation ') {
            steps {
                sh '''
                    env | grep -e PATH -e JAVA_HOME

                    which java
                    java --version
                    
                    which mvn
                    mvn --version
                '''

            }
        }
        stage('Checkout') {
            steps {

                sh "echo checkout dev branch"
                git branch: 'dev', url: 'git@github.com:vivek679/employee-management-system.git'
                sh "echo checkout successfully"
            }
        }
        stage('Build') {
            steps {
                sh '''
                    echo "building application"
                    mvn clean install
                    echo passed
                    docker build . -t employee-management:v2 -f ./docker/Dockerfile
                    echo image build
                    '''
            }
        }
        stage('Run on container') {
            steps {
                sh '''
                    docker run -p 9092:9090 --name emp-management-container -d employee-management:v1
                '''
            }
        }
    }
}
