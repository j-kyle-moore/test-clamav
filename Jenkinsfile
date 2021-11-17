pipeline {
  agent any
  environment {
    SCM_SOURCE = "Bitbucket"
    SCM_REPO_NAME = "jenkins-pull-reg1-apache2"
    SCM_REPO_CREDS = "j7-bitbucket"
    SCM_REPO_URL = "bitbucket.di2e.net/scm/ddjtdev/jenkins-pull-reg1-apache2.git"
    SCM_REPO_BRANCH = "DDJTDEV-2078-jenkins-pipeline-for-pulling-latest-registry1-apache2"

    JENKINS_SERVER = "jenkins-commercial.rke2-app.km.test"
    JENKINS_PIPELINE_NAME = "jenkins-pull-reg1-apache2"

    HARBOR_SERVER = "harbor.rke2-app.km.test"
    HARBOR_REPO1 = "ead_base_images"
    HARBOR_REPO2 = "eaddev"
    IMAGE_NAME = "apache2"
    IMAGE_TAG = "latest"

    REGISTRY_CERT_LOC = "/kaniko/ssl/km-test-certs/km_test_ca.crt"
    LOG_LEVEL = "debug"

    CLAMAV_FILES = "/home/jenkins/agent/workspace/*"

    EMAIL_RECPTS = "moore.kyle@idsi.com, j.kyle.moore@gmail.com"
  }

  stages {
    stage('SCM Checkout') {
      steps {
        echo "SCM Checkout from ${env.SCM_SOURCE} ${env.SCM_REPO_NAME}"
        git(credentialsId: "${env.SCM_REPO_CREDS}", url: "https://${env.SCM_REPO_URL}", branch: "${env.SCM_REPO_BRANCH}")
      }
    }
  }
}
