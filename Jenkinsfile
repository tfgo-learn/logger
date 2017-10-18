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
				withEnv([
				    'GOPATH=' + pwd(),
				    'PATH+EXTRA=' + pwd() + '/bin/' + ':/usr/local/go/bin/'])
				{
					sh "go get -u github.com/golang/dep/cmd/dep"
					sh "cd ${projPath} && dep ensure && go build"
				}
			}
		}
	}
}