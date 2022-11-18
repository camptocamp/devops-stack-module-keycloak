# Changelog

## 1.0.0-alpha.1 (2022-11-18)


### ⚠ BREAKING CHANGES

* move Terraform module at repository root
* use var.cluster_info

### Features

* allow * as redirect url ([84e374a](https://github.com/camptocamp/devops-stack-module-keycloak/commit/84e374a20a6e5cf48c98ec560b38581226ea4771))
* allow profiles ([d417123](https://github.com/camptocamp/devops-stack-module-keycloak/commit/d417123f56030fdf41805885df66e652eec29f5c))
* default oidc values ([3dbdde6](https://github.com/camptocamp/devops-stack-module-keycloak/commit/3dbdde66a36ee10c069022656434449e575a105a))
* pass profiles as a list ([3e0533c](https://github.com/camptocamp/devops-stack-module-keycloak/commit/3e0533c288dd7aa89496d285c48ec60339e88af7))
* user_map defaults ([2f658db](https://github.com/camptocamp/devops-stack-module-keycloak/commit/2f658db414400ce6b154b86406d1fd9fddaaa456))


### Bug Fixes

* add keycloak-operator ([8f15d82](https://github.com/camptocamp/devops-stack-module-keycloak/commit/8f15d82805e65da9b200919263e71f040917edd5))
* allow keycloak-operator helm chart in project ([fd8a45b](https://github.com/camptocamp/devops-stack-module-keycloak/commit/fd8a45b36c34c62549d7a7aa931fe2d842fffdd7))
* **charts:** use ingress v1 ([c7356b7](https://github.com/camptocamp/devops-stack-module-keycloak/commit/c7356b7edfd4f69637d16962b214cf32003ad15d))
* default namespace is keycloak ([75d8636](https://github.com/camptocamp/devops-stack-module-keycloak/commit/75d86364a4fc0bc0cf0b155f0a6ece91a993ba23))
* do not delay Helm values evaluation ([4950816](https://github.com/camptocamp/devops-stack-module-keycloak/commit/495081659d2caff2d28c9c590c7616be309e7cb2))
* helm values ([862fcdd](https://github.com/camptocamp/devops-stack-module-keycloak/commit/862fcdd9ef315a033251a8cbc84b2c7535c131c6))
* no helm prefix ([64cb638](https://github.com/camptocamp/devops-stack-module-keycloak/commit/64cb63806fd396593c7349cba2bb0afaed63a9f0))
* README ([4b1f29c](https://github.com/camptocamp/devops-stack-module-keycloak/commit/4b1f29c530a73e380a63ced7217f6d38dc14e7ec))
* wait for operator to ensure CRDs ([6befb7c](https://github.com/camptocamp/devops-stack-module-keycloak/commit/6befb7caf0204564c3383ace00be7cd6ea196050))


### Code Refactoring

* move Terraform module at repository root ([2ff3ed2](https://github.com/camptocamp/devops-stack-module-keycloak/commit/2ff3ed2e860bcdf6fb05093476faad9e28f4d0fa))
* use var.cluster_info ([a49d9ed](https://github.com/camptocamp/devops-stack-module-keycloak/commit/a49d9ed47b76b56a8c1371b2ccfef6dc49903b7d))


### Continuous Integration

* add central workflows including release-please ([#4](https://github.com/camptocamp/devops-stack-module-keycloak/issues/4)) ([aba575c](https://github.com/camptocamp/devops-stack-module-keycloak/commit/aba575cd447e6f85004d158e1debb3ef6ed5d1d5))
