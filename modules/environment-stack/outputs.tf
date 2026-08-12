output "vpc_id" { value = module.vpc.vpc_id }
output "web_instance_ids" { value = module.web.instance_ids }
output "app_instance_ids" { value = module.app.instance_ids }
output "database_endpoint" {
  value     = module.database.endpoint
  sensitive = true
}
output "load_balancer_dns_name" { value = module.networking.load_balancer_dns_name }
output "application_bucket" { value = module.storage.bucket_id }
