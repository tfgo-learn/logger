#!/usr/bin/env groovy

pipeline {
    agent { docker 'golang:1.9.1-alpine' }
    stages {
        stage('build') {
            steps {
                withEnv(['GOPATH=' + pwd()]){
		    sh 'go get -u github.com/golang/dep/cmd/dep'
                    sh 'dep ensure'
                    sh 'go build'
                }
            }
        }
    }
}
