terraform {
  backend "s3" {
    bucket         = "bs101-uat-app-buckett"     #Create your s3 bucket 
    key            = "env/uat/terraform.tfstate" # Define your desired path for the state file within the bucket
    region         = "us-west-2"                 # Define the appropriate AWS region
    dynamodb_table = "bs101-uat-app-db"          # Your DynamoDB table name for state locking
    encrypt        = true                        # Enable encryption for the state file
  }
}