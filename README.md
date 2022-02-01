# devops-stack-module-keycloak

A [DevOps Stack](https://devops-stack.io) module to deploy and configure [Keycloak](https://www.keycloak.org/) as an OIDC provider.


## Usage

```hcl
module "oidc" {
  source = "git::https://github.com/camptocamp/devops-stack-module-keycloak.git//modules"

  cluster_info = module.cluster.info

  cluster_issuer = "ca-issuer"

  depends_on = [ module.ingress ]
}
```
