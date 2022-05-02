resource "null_resource" "dependencies" {
  triggers = var.dependency_ids
}

resource "argocd_project" "this" {
  metadata {
    name      = "keycloak"
    namespace = var.argocd.namespace
    annotations = {
      "devops-stack.io/argocd_namespace" = var.argocd.namespace
    }
  }

  spec {
    description = "keycloak application project"
    source_repos = [
      "https://github.com/camptocamp/devops-stack-module-keycloak.git",
      "https://github.com/keycloak/keycloak-operator.git"
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
  input = local.all_yaml
}

resource "argocd_application" "operator" {
  metadata {
    name      = "keycloak-operator"
    namespace = var.argocd.namespace
  }

  wait = true

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/keycloak/keycloak-operator.git"
      path            = "deploy"
      target_revision = "15.0.1"
    }

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    sync_policy {
      automated = {
        prune     = true
        self_heal = true
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
    namespace = var.argocd.namespace
  }

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/camptocamp/devops-stack-module-keycloak.git"
      path            = "charts/keycloak"
      target_revision = "main"
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
        prune     = true
        self_heal = true
      }

      sync_options = [
        "CreateNamespace=true"
      ]
    }
  }

  depends_on = [argocd_application.operator]
}

resource "random_password" "clientsecret" {
  length  = 16
  special = false
}

#data "kubernetes_secret" "keycloak_admin_password" {
#  metadata {
#    name      = "credential-keycloak"
#    namespace = "keycloak"
#  }
#}

resource "random_password" "keycloak_passwords" {
  for_each = local.keycloak.user_map
  length   = 16
  special  = false
}

resource "null_resource" "this" {
  depends_on = [
    resource.argocd_application.this,
  ]
}
