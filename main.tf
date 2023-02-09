resource "null_resource" "dependencies" {
  triggers = var.dependency_ids
}

resource "random_password" "db_password" {
  count  = var.database == null ? 1 : 0
  length = 32
}

resource "argocd_project" "this" {
  metadata {
    name      = "keycloak"
    namespace = var.argocd_namespace
  }

  spec {
    description = "Keycloak application project"
    source_repos = [
      "https://github.com/camptocamp/devops-stack-module-keycloak.git",
    ]

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    orphaned_resources {
      warn = true
    }

    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }
  }
}

data "utils_deep_merge_yaml" "values" {
  input = [for i in concat(local.helm_values, var.helm_values) : yamlencode(i)]
}

resource "argocd_application" "operator" {
  metadata {
    name      = "keycloak-operator"
    namespace = var.argocd_namespace
  }

  # TODO Add automated sync variabilization here and on the next argocd application resource
  wait = true

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/camptocamp/devops-stack-module-keycloak.git"
      path            = "charts/keycloak-operator"
      target_revision = var.target_revision
    }

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    sync_policy {
      automated = {
        allow_empty = false
        prune       = true
        self_heal   = true
      }

      retry {
        backoff = {
          duration     = ""
          max_duration = ""
        }
        limit = "0"
      }

      sync_options = [
        "CreateNamespace=true"
      ]
    }
  }

  depends_on = [
    resource.null_resource.dependencies,
  ]
}

resource "argocd_application" "this" {
  metadata {
    name      = "keycloak"
    namespace = var.argocd_namespace
  }

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/camptocamp/devops-stack-module-keycloak.git"
      path            = "charts/keycloak"
      target_revision = var.target_revision
      helm {
        values = data.utils_deep_merge_yaml.values.output
      }
    }

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    sync_policy {
      automated = {
        allow_empty = false
        prune       = true
        self_heal   = true
      }

      retry {
        backoff = {
          duration     = ""
          max_duration = ""
        }
        limit = "0"
      }

      sync_options = [
        "CreateNamespace=true"
      ]
    }
  }

  depends_on = [
    resource.argocd_application.operator
  ]
}


resource "null_resource" "wait_for_keycloak" {
  # Until curl successfully completes the requested transfer, wait 10 seconds and retry for 180 seconds until timeout.
  # --retry-all-errors makes curl retry even on non-transient HTTP errors (e.g. 404)
  # -f makes curl fail on server errors
  # -s prevents it from printing messages and the progress meter
  # -o /dev/null discards the output message
  # -k ignores self-signed SSL certificates
  provisioner "local-exec" {
    command = "curl --retry 180 -f --retry-all-errors --retry-delay 10 -s -o /dev/null -k 'https://keycloak.apps.${var.cluster_name}.${var.base_domain}'"
  }

  depends_on = [
    resource.argocd_application.this,
  ]
}

data "kubernetes_secret" "admin_password" {
  metadata {
    name      = "keycloak-initial-admin"
    namespace = var.namespace
  }
  depends_on = [
    resource.null_resource.wait_for_keycloak
  ]
}

resource "null_resource" "this" {
  depends_on = [
    resource.null_resource.wait_for_keycloak
  ]
}
