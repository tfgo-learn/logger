#!/usr/bin/env groovy

pipeline {
    agent { docker 'golang:1.9.1-alpine' }
    stages {
        stage('build') {
            steps {
                withEnv(['GOPATH=' + pwd()]){
                    sh 'dep ensure'
                    sh 'go build'
                }
            }
        }
    }
}
