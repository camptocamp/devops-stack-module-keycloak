locals {
  helm_values = [
    {
      keycloak = {
        name = "keycloak"
        # Database creds are shown in tfm plan.
        # TODO manage this. Proposal: create namespace and secret before app.
        database = var.database != null ? merge(var.database, {
          create   = false
          username = base64encode(var.database.username)
          password = base64encode(var.database.password)
          }) : {
            # TODO doc that the fallback map (experimental ephemeral postgresql server) should never be used in production.
            create   = true
            vendor   = "postgres"
            username = base64encode("postgres")
            password = base64encode(random_password.db_password.0.result)
            host     = "postgres-db"
          }
        ingress = {
          enabled = true
          annotations = {
            # TODO add condition cert-manager enabled
            "cert-manager.io/cluster-issuer" = var.cluster_issuer
            # TODO add condition traefik enabled
            "traefik.ingress.kubernetes.io/router.entrypoints" = "websecure"
            "traefik.ingress.kubernetes.io/router.tls"         = "true"
          }
          hosts = [
            {
              host = "keycloak.apps.${var.cluster_name}.${var.base_domain}"
              path = "/"
            },
            {
              host = "keycloak.apps.${var.base_domain}"
              path = "/"
            }
          ]
          tls = [
            {
              secret = "keycloak-tls"
              hosts = [
                "keycloak.apps.${var.cluster_name}.${var.base_domain}",
                "keycloak.apps.${var.base_domain}"
              ]
            }
          ]
        }
      }
    }
  ]
}
