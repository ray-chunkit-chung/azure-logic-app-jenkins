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

  environment {
      LOCATION = 'test1'
      RESOURCEGROUP_NAME = 'test2'
      SUBSCRIPTION_NAME = 'test3'
  }

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
        echo 'build'
        // sh "chmod +x -R ${env.WORKSPACE}"
        withCredentials([
          usernamePassword(credentialsId: 'azure-service-principal', usernameVariable: 'user', passwordVariable: 'pwd')
        ]) {
          sh "az login --service-principal -u ${user} -p ${pwd} --tenant ${params.TENANT_ID}"
        }
        sh "az group create --location ${params.LOCATION} \
                            --name ${params.RESOURCEGROUP_NAME} \
                            --subscription ${params.SUBSCRIPTION_NAME}"
        sh "az deployment group create --subscription ${params.SUBSCRIPTION_NAME} \
                           --resource-group ${params.RESOURCEGROUP_NAME} \
                           --template-file ArmTemplate/logicApp/httpGet/template.json"
      }
    }
    stage('test') {
      steps {
        echo 'prepare for tests'
        echo 'pip install --upgrade -r requirement'
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
        // sshagent(credentials: ['github-ray-chunkit-chung']) {
        //   sh 'git tag -f latest'
        //   sh 'git push -f git@github.com:ray-chunkit-chung/azure-logic-app-jenkins.git origin/release latest'
        // }
        echo 'push to artifacts'
        sh "yes | az group delete --name ${params.RESOURCEGROUP_NAME} --subscription ${params.SUBSCRIPTION_NAME} --yes"
      }
    }
    // stage('Deploy to PROD') {
    //     when { tag "release-*" }
    //     steps {
    //         echo 'Deploying only because this commit is tagged...'
    //         sh 'make deploy'
    //     }
    // }
  }
}
