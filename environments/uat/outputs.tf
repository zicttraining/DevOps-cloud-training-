output "vpc_id" { value = module.environment.vpc_id }
output "web_instance_ids" { value = module.environment.web_instance_ids }
output "app_instance_ids" { value = module.environment.app_instance_ids }
output "database_endpoint" {
  value     = module.environment.database_endpoint
  sensitive = true
}
output "load_balancer_dns_name" { value = module.environment.load_balancer_dns_name }
output "application_bucket" { value = module.environment.application_bucket }
