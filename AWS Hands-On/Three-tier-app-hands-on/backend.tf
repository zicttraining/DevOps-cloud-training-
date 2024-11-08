terraform {
  backend "s3" {
    bucket = "bmedevapp"
    key    = "path/to/terraform.tfstate"  # Define your desired path for the state file within the bucket
    region = "us-west-2"                  # Define the appropriate AWS region
    encrypt = true                        # Enable encryption for the state file
  }
}
