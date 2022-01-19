# devops-stack-module-keycloak

A [DevOps Stack](https://devops-stack.io) module to deploy and configure [Keycloak](https://www.keycloak.org/) as an OIDC provider.


## Usage

```hcl
module "oidc" {
  source = "git::https://github.com/camptocamp/devops-stack-module-keycloak.git//modules"

  cluster_name   = var.cluster_name
  argocd         = {
    namespace = module.cluster.argocd_namespace
    domain    = module.cluster.argocd_domain
  }
  base_domain    = module.cluster.base_domain
  cluster_issuer = "ca-issuer"

  depends_on = [ module.ingress ]
}
```
