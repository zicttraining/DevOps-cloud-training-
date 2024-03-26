# To authenticate Jenkins with EC2 instances, you can use AWS Credentials in Jenkins. 

Here is an example of a Jenkinsfile that uses the withAWS() step to authenticate with AWS and connect to an EC2 instance:
```
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = 'your_access_key_id'
        AWS_SECRET_ACCESS_KEY = 'your_secret_access_key'
    }
    stages {
        stage('Connect to EC2') {
            steps {
                withAWS(credentials: 'aws-credentials') {
                    script {
                        def ec2Instance = 'your-ec2-instance-id'
                        def ec2Region = 'us-east-1'
                        def ec2User = 'ec2-user'
                        def privateKey = readFile('path/to/your/private_key.pem')

                        def sshCommand = "ssh -i ${privateKey} -o StrictHostKeyChecking=no ${ec2User}@${awsEC2.instances.find { it.instanceId == ec2Instance }.publicDnsName} 'echo Hello from EC2!'"
                        sh sshCommand
                    }
                }
            }
        }
    }
}
```

#### Replace the placeholders with your actual AWS credentials, EC2 instance ID, and private key path. This Jenkinsfile uses the withAWS() step to authenticate with AWS and then uses SSH to connect to the EC2 instance
