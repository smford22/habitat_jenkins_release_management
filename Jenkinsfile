
pipeline {
    agent any

    environment {
        HAB_NOCOLORING = true
        HAB_ORIGIN = 'company-origin'
    }

    stages {
        stage('build project_nodejs') {
            steps {
              dir("${workspace}/project_nodejs") {
                habitat task: 'build', directory: '.', origin: env.HAB_ORIGIN
              }
            }
        }
        stage('upload project_nodejs') {
            steps {
                withCredentials([string(credentialsId: 'depot-token', variable: 'HAB_AUTH_TOKEN')]) {
                    dir("${workspace}/project_nodejs") {
                      habitat task: 'upload', directory: "${workspace}/project_nodejs/habitat", authToken: env.HAB_AUTH_TOKEN
                    }
                }
            }
        }
    }
}
