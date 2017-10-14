#!/usr/bin/env groovy

pipeline {
	agent {
		dockerfile {
			filename 'Dockerfile'
		}
	}
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
