pipeline {
    agent any

    tools {
        jdk 'JDK8'
        maven 'Maven3'
    }

    environment {
        APP_ENV = 'dev'
    }

    stages {

        stage('Verify Java Version') {
            steps {
                sh 'java -version'
            }
        }

        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Gajarla/Ekart.git',
                    branch: "${env.BRANCH_NAME}"
            }
        }

        stage('Set Environment') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'develop') {
                        env.APP_ENV = 'dev'
                    } else if (env.BRANCH_NAME == 'uat') {
                        env.APP_ENV = 'uat'
                    } else {
                        error "No environment mapped for branch ${env.BRANCH_NAME}"
                    }
                }
                echo "Environment selected: ${env.APP_ENV}"
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'uat'
                }
            }
            steps {
                sh 'chmod +x scripts/*.sh'
                sh "./scripts/deploy-${env.APP_ENV}.sh"
            }
        }
    }

    post {
        success {
            echo 'Build & Deployment successful 🎉'
        }
        failure {
            echo 'Build or Deployment failed ❌'
        }
    }
}
