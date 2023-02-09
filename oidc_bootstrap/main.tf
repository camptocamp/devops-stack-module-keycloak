resource "null_resource" "dependencies" {
  triggers = var.dependency_ids
}

resource "keycloak_realm" "devops_stack" {
  enabled           = true
  realm             = "devops-stack"
  display_name      = "DevOps Stack"
  display_name_html = "<img width='200px' src='https://raw.githubusercontent.com/camptocamp/devops-stack/gh-pages/images/devops-stack-logo_light_by_c2c_black.png' alt='DevOps Stack Logo'/>"

  login_theme = "keycloak"

  access_code_lifespan = "1h"

  ssl_required    = "external"
  password_policy = "upperCase(1) and length(8) and forceExpiredPasswordChange(365) and notUsername"
  attributes = {
    terraform = "true"
  }

  # TODO Verify if we need these settings as it seems most of them (the `headers` mainly) are already defaults on Keycloak
  security_defenses {
    headers {
      x_frame_options                     = "DENY"
      content_security_policy             = "frame-src 'self'; frame-ancestors 'self'; object-src 'none';"
      content_security_policy_report_only = ""
      x_content_type_options              = "nosniff"
      x_robots_tag                        = "none"
      x_xss_protection                    = "1; mode=block"
      strict_transport_security           = "max-age=31536000; includeSubDomains"
    }
    brute_force_detection {
      permanent_lockout                = false
      max_login_failures               = 10
      wait_increment_seconds           = 60
      quick_login_check_milli_seconds  = 1000
      minimum_quick_login_wait_seconds = 60
      max_failure_wait_seconds         = 900
      failure_reset_time_seconds       = 43200
    }
  }

  # TODO Discuss adding the meta-argument lifecycle with ignore_changes to avoid deleting changes done on the WebUI

  depends_on = [
    resource.null_resource.dependencies
  ]
}

resource "random_password" "client_secret" {
  length  = 32
  special = false
}

resource "keycloak_openid_client" "devops_stack" {
  enabled = true

  realm_id = resource.keycloak_realm.devops_stack.id

  name          = "DevOps Stack Applications"
  client_id     = "devops-stack-applications"
  client_secret = resource.random_password.client_secret.result

  access_type                  = "CONFIDENTIAL"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*"
  ]
  # TODO Add a variable to set the redirect uris instead of using a wildcard
  # valid_redirect_uris = [
  #   "https://*.apps.${var.cluster_name}.${var.base_domain}/*"
  # ]
}

resource "keycloak_openid_client_scope" "devops_stack" {
  realm_id               = resource.keycloak_realm.devops_stack.id
  name                   = "groups"
  description            = "OpenID Connect scope to map a user's group memberships to a claim"
  include_in_token_scope = true
}

resource "keycloak_openid_client_default_scopes" "client_default_scopes" {
  realm_id  = resource.keycloak_realm.devops_stack.id
  client_id = resource.keycloak_openid_client.devops_stack.id

  default_scopes = [
    "profile",
    "email",
    "roles",
    "web-origins",
    resource.keycloak_openid_client_scope.devops_stack.name,
  ]
}

resource "keycloak_group" "devops_stack_admins" {
  realm_id = resource.keycloak_realm.devops_stack.id
  name     = "devops-stack-admins"
}

resource "random_password" "devops_stack_admin" {
  length  = 32
  special = false
}

resource "keycloak_user" "devops_stack_admin" {
  realm_id = resource.keycloak_realm.devops_stack.id

  username = "devopsadmin"
  initial_password {
    value = resource.random_password.devops_stack_admin.result
  }

  first_name     = "Administrator"
  last_name      = "DevOps Stack"
  email          = "devopsadmin@devops-stack.io"
  email_verified = true
}

resource "keycloak_user_groups" "devops_stack_admin" {
  realm_id = resource.keycloak_realm.devops_stack.id
  user_id  = resource.keycloak_user.devops_stack_admin.id

  group_ids = [
    resource.keycloak_group.devops_stack_admins.id
  ]
}

resource "null_resource" "this" {
  depends_on = [
    resource.keycloak_realm.devops_stack,
    resource.keycloak_group.devops_stack_admins,
    resource.keycloak_user.devops_stack_admin,
    resource.keycloak_user_groups.devops_stack_admin,
  ]
}

# TODO Variabilize the users and realms to be created or leave it as is to only bootstrap the admin user
