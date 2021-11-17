pipeline {
  agent any
  stages {
    stage('Checkout SCM') {
      steps {
        git(url: 'bitbucket.di2e.net/scm/ddjtdev/jenkins-pull-reg1-apache2.git', branch: 'DDJTDEV-2078-jenkins-pipeline-for-pulling-latest-registry1-apache2', credentialsId: 'j7-bitbucket')
      }
    }

  }
}