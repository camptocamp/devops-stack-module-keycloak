output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}

output "oidc" {
  description = "Object containing multiple OIDC configuration values."
  value       = local.oidc
  sensitive   = true
}

# TODO Add username output just in case
output "devops_admin_password" {
  value     = resource.random_password.devops_stack_admin.result
  sensitive = true
}
# TODO Add dependency ids output and variable as well as main resources
