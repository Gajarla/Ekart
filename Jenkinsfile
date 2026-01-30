pipeline {
    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    environment {
        APP_ENV = ''
    }

    stages {

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
                    }
                }
                echo "Environment selected: ${APP_ENV}"
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
                sh "./scripts/deploy-${APP_ENV}.sh"
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
