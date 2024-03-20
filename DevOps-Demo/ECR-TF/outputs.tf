output "repository_url" {
  description = "The URL of the created ECR repository."
  value       = aws_ecr_repository.my_repository.repository_url
}
