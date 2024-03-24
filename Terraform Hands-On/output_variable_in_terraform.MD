# In Terraform, output variables are used to expose a subset of a child module's resource attributes to a parent module or to print values from a root module in the CLI output after running terraform apply. Output variables can be used to:


1. Expose a subset of a child module's resource attributes to a parent module.

2. Print values from a root module in the CLI output after running 'terraform apply'.

3. Allow other configurations to access the outputs of a root module via the 'terraform_remote_state' data source.


To declare an output variable in Terraform, you must declare them in an 'output' block.  

Here is an example of how to declare an output variable in Terraform:
```
output "instance_ids" {
  value       = "${join(", ", aws_instance.example.*.id)}"
  description = "IDs of the EC2 instances"
}
```

#### This example declares an output variable called 'instance_ids' with a value that is a comma-separated list of the IDs of the EC2 instances. The 'value' field defines the value of the output variable, while the 'description' field provides a brief explanation of what the output represents.



