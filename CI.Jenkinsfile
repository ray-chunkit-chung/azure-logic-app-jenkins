/* groovylint-disable-next-line CompileStatic */
pipeline {
  agent {
    label 'jenkins-agent-local'
  }

  ////////////////////////////////////////////////
  // When new changes in the code release branch
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
        git branch: 'release',
            url: 'https://github.com/ray-chunkit-chung/azure-logic-app-jenkins.git'
        sh 'ls -lat'
      }
    }
    stage('build') {
      steps {
        echo 'prepare for tests'
        echo 'pip install --upgrade -r requirement'
        sh 'script/create_resource_group.sh'
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
        sshagent(credentials: ['github-ray-chunkit-chung']) {
          sh 'git tag -f latest'
          sh 'git push -f git@github.com:ray-chunkit-chung/azure-logic-app-jenkins.git origin/release latest'
        }
      }
    }
  }
}
