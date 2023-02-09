terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "~> 4"
    }
    random = {
      source  = "random"
      version = "~> 3"
    }
    null = {
      source  = "null"
      version = "~> 3"
    }
  }
}

# TODO The fact that we define this provider here causes problems when trying to remove the entire module from the root
# code. This happens because terraform tries to delete resources for which there no longer is a provider defined.
# A workaround is removing all references to said module from the statefile or to remove the provider from inside the module.
provider "keycloak" {
  client_id                = "admin-cli"
  username                 = var.keycloak_admin.username
  password                 = var.keycloak_admin.password
  url                      = "https://keycloak.apps.${var.cluster_name}.${var.base_domain}"
  tls_insecure_skip_verify = var.tls_insecure_skip_verify
  initial_login            = false # Do no try to setup the provider before Keycloak is provisioned
}
