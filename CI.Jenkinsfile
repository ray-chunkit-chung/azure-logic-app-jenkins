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
        input {
          message 'Should we continue?'
          ok 'Yes, we should.'
          submitter 'developer name'
          /* groovylint-disable-next-line NestedBlockDepth */
          parameters {
              string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
          }
        }
      }
    }
    stage('artifacts') {
      steps {
        sh 'git tag latest'
        sh 'git push origin latest'
      }
    }
  }
}
