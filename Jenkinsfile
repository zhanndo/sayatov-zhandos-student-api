pipeline {
    agent any

    environment {
        STUDENT    = 'Zhandos Sayatov (IT2-2309)'
        IMAGE_NAME = 'sayatov-zhandos-student-api'
        IMAGE_TAG  = 'v1.0-sayatov-zhandos'
        // JDK 21 installed by Homebrew together with Jenkins
        JAVA_HOME  = '/opt/homebrew/opt/openjdk@21'
        // docker + docker-credential-desktop live in /usr/local/bin
        PATH       = "/opt/homebrew/opt/openjdk@21/bin:/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    }

    triggers {
        // Check GitHub for new commits every 2 minutes
        pollSCM('H/2 * * * *')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'echo "Build started for student: $STUDENT"'
                sh 'git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x gradlew'
                sh './gradlew clean compileJava --no-daemon'
            }
        }

        stage('Test') {
            steps {
                // If a test fails, this stage fails and the pipeline stops here
                sh './gradlew test --no-daemon'
            }
            post {
                always { junit 'build/test-results/test/*.xml' }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Verify') {
            steps {
                sh 'docker image inspect $IMAGE_NAME:$IMAGE_TAG --format "Image {{.RepoTags}} created {{.Created}} size {{.Size}} bytes"'
                sh 'docker images $IMAGE_NAME'
                sh 'echo "Image $IMAGE_NAME:$IMAGE_TAG is ready. Student: $STUDENT"'
            }
        }
    }

    post {
        success { echo "SUCCESS: pipeline finished for $STUDENT" }
        failure { echo "FAILURE: check the red stage in Console Output ($STUDENT)" }
    }
}
