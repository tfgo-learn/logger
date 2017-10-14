#!/usr/bin/env groovy

projPath = 'src/github.com/tfgo-learn/logger'

pipeline {
	agent {
		dockerfile {
			filename "${projPath}/Dockerfile"
		}
	}
	stages {
		stage('build') {
			steps {
				withEnv(['GOPATH=' + pwd()]){
					sh "cd ${projPath} && DEPNOLOCK=1 dep ensure"
					sh "cd ${projPath} && go build"
				}
			}
		}
	}
}
