output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}

output "keycloak_admin" {
  description = "Credentials for the administrator user created on deployment."
  value = {
    username = "admin"
    password = var.admin_password == null ? resource.random_password.admin_password.0.result : var.admin_password
  }
  sensitive   = true
}
