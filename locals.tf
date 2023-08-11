locals {
  helm_values = [{
    keycloak = {
      name = "keycloak"
      # Database creds are shown in tfm plan.
      # TODO manage this. Proposal: create namespace and secret before app.
      database = var.database != null ? merge(var.database, {
        create   = false
        username = base64encode(var.database.username)
        password = base64encode(var.database.password)
        # TODO review the previous merge and fix
        }) : {
        # TODO doc that the fallback map (experimental ephemeral postgresql server) should never be used in production.
        create   = true
        vendor   = "postgres"
        username = "<path:secret/data/devops-stack/keycloak#keycloak-db-username | base64encode>"
        password = "<path:secret/data/devops-stack/keycloak#keycloak-db-password | base64encode>"
        host     = "keycloak-postgres-db"
      }
      ingress = {
        enabled = true
        annotations = {
          "cert-manager.io/cluster-issuer"                   = "${var.cluster_issuer}"
          "traefik.ingress.kubernetes.io/router.entrypoints" = "websecure"
          "traefik.ingress.kubernetes.io/router.middlewares" = "traefik-withclustername@kubernetescrd"
          "traefik.ingress.kubernetes.io/router.tls"         = "true"
          "ingress.kubernetes.io/ssl-redirect"               = "true"
          "kubernetes.io/ingress.allow-http"                 = "false"
        }
        hosts = [
          {
            host = "keycloak.apps.${var.base_domain}"
            path = "/"
          },
          {
            host = "keycloak.apps.${var.cluster_name}.${var.base_domain}"
            path = "/"
          },
        ]
        tls = [{
          secretName = "keycloak-tls"
          hosts = [
            "keycloak.apps.${var.base_domain}",
            "keycloak.apps.${var.cluster_name}.${var.base_domain}"
          ]
        }]
      }
    }
  }]
}
