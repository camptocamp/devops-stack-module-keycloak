output "id" {
  value = resource.null_resource.this.id
}

output "oidc" {
  description = "OIDC values"
  sensitive   = true
  value       = local.oidc
}

output "keycloak_users" {
  value     = { for username, infos in local.user_map : username => lookup(infos, "password") }
  sensitive = true
}

#output "keycloak_admin_password" {
#  description = "The password of Keycloak's admin user."
#  value       = data.kubernetes_secret.keycloak_admin_password.data.ADMIN_PASSWORD
#  sensitive   = true
#}
