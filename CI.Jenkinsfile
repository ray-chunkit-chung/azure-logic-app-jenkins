/* groovylint-disable-next-line CompileStatic */
pipeline {
  agent {
    label 'jenkins-agent-local'
  }

  ////////////////////////////////////////////////
  // When new changes in the code dev branch
  // Analyze the quality of the source code
  // Build
  // Execute all unit tests
  // Execute all integration tests
  // Generate deployable artifacts
  // Report status
  ////////////////////////////////////////////////
  stages {
    stage('checkout') {
      steps {
        git branch: 'dev',
            url: 'https://github.com/ray-chunkit-chung/azure-logic-app-jenkins.git'
        sh 'ls -lat'
      }
    }
    stage('build') {
      steps {
        echo 'prepare for tests'
        echo 'pip install --upgrade -r requirement'
      }
    }
    stage('test') {
      steps {
        echo 'perform tests'
        echo 'python tests.py'
      }
    }
    stage('approval') {
      steps {
        script {
          input(
            message: 'Should we proceed?',
            ok: 'Proceed'
          )
        }
      }
    }
    stage('artifacts') {
      steps {

        withCredentials([sshUserPrivateKey(credentialsId: 'github-ray-chunkit-chung', keyFileVariable: 'SSH_KEY')]) {
            sh 'echo ssh -i $SSH_KEY -l git -o StrictHostKeyChecking=no \\"\\$@\\" > ~./local_ssh.sh'
            sh 'chmod +x ~./local_ssh.sh'
            withEnv(['GIT_SSH=./local_ssh.sh']) {
                git branch: 'dev',
                    url: 'git@github.com:ray-chunkit-chung/azure-logic-app-jenkins.git'
                sh 'git tag -f latest'
                sh 'git push origin latest'
            }
        }
      }
    }
  }
}
