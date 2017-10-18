#!/usr/bin/env groovy

projPath = 'src/github.com/tfgo-learn/logger'

pipeline {
	agent {
		docker {
			image "golang:1.9.1"
		}
	}
	stages {
		stage('build') {
			steps {
				withEnv(['GOPATH=' + pwd()]){
					sh "env && go get -u github.com/golang/dep/cmd/dep"
					sh "env && cd ${projPath} && dep ensure"
					sh "env && cd ${projPath} && go build"
				}
			}
		}
	}
}
