#!/usr/bin/env groovy

pipeline {
	agent {
		docker {
			image "golang:1.9.1"
		}
	}
	stages {
		stage('build') {
			steps {
				script {
					def projPath = "src/github.com/tfgo-learn/logger"
					def goPath = pwd()

					withEnv([
					    "GOPATH=${goPath}",
					    "PATH+EXTRA=${goPath}/bin:/usr/local/go/bin"])
					{
						sh "cd ${projPath} && make"
					}				
				}
			}
		}
	}
}
