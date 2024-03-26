# To create a Jenkins pipeline that picks up a Jenkinsfile from a GitHub repository, you can use the Jenkinsfile option in the Pipeline script from SCM configuration. Here is the syntax for creating such a pipeline:
```sh
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Checkout the Jenkinsfile from the GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/your-username/your-repo.git']]])
                // Run the Jenkinsfile
                sh 'jenkinsfile-runner'
            }
        }
    }
}
```

#### In this example, the checkout step checks out the Jenkinsfile from the specified GitHub repository, and the sh step runs the Jenkinsfile using the Jenkinsfile Runner. You can customize the checkout step to specify the branch or tag to check out, and you can customize the sh step to use a different command to run the Jenkinsfile.
