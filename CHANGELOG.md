# Changelog

## [3.1.1](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v3.1.0...v3.1.1) (2024-03-01)


### Bug Fixes

* remove legacy ingress annotations ([#33](https://github.com/camptocamp/devops-stack-module-keycloak/issues/33)) ([ede4ddb](https://github.com/camptocamp/devops-stack-module-keycloak/commit/ede4ddbc27f1f6cb4200efc7cc76183046b3252d))

## [3.1.0](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v3.0.0...v3.1.0) (2024-02-23)


### Features

* add a subdomain variable ([fa10461](https://github.com/camptocamp/devops-stack-module-keycloak/commit/fa1046124e30684155a62d3863b6bbaad8a38672))


### Bug Fixes

* also make the oidc_bootstrap's subdomain variable nullable ([18f9435](https://github.com/camptocamp/devops-stack-module-keycloak/commit/18f94356c2b17dd301c6030a6e34e82a183b6948))
* make subdomain variable non-nullable ([7fa7e35](https://github.com/camptocamp/devops-stack-module-keycloak/commit/7fa7e3570f581f507982e87832952e2a0e147ed2))
* remove annotation for the redirection middleware ([ab0171c](https://github.com/camptocamp/devops-stack-module-keycloak/commit/ab0171cdd29e16fb50bd6fd05ef3c62ebf4e8d93))

## [3.0.0](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v2.1.0...v3.0.0) (2024-01-19)


### ⚠ BREAKING CHANGES

* remove the ArgoCD namespace variable
* remove the namespace variable
* hardcode the release name to remove the destination cluster

### Bug Fixes

* change the default cluster issuer and disabling of TLS verification ([e58d8e8](https://github.com/camptocamp/devops-stack-module-keycloak/commit/e58d8e8271165f252f179228494e150ba35bb785))
* hardcode the release name to remove the destination cluster ([b395213](https://github.com/camptocamp/devops-stack-module-keycloak/commit/b3952132a37c60080fe67632ed8024b56ba0fe1d))
* remove the ArgoCD namespace variable ([2443680](https://github.com/camptocamp/devops-stack-module-keycloak/commit/2443680d96e972fd9f060fe04051ad5b18ec9381))
* remove the namespace variable ([a434bb1](https://github.com/camptocamp/devops-stack-module-keycloak/commit/a434bb185f2a1c7a4a063801555f15df730ea377))

## [2.1.0](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v2.0.1...v2.1.0) (2023-10-19)


### Features

* add standard variables and variable to add labels to Argo CD app ([f564ec5](https://github.com/camptocamp/devops-stack-module-keycloak/commit/f564ec57681d7d5e07044c3435fe1abacac677e6))
* add variables to set AppProject and destination cluster ([8510db2](https://github.com/camptocamp/devops-stack-module-keycloak/commit/8510db2fbc2392f8516488edcead524528bfed2f))

## [2.0.1](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v2.0.0...v2.0.1) (2023-08-09)


### Bug Fixes

* readd support to deactivate auto-sync which was broken by [#20](https://github.com/camptocamp/devops-stack-module-keycloak/issues/20) ([#22](https://github.com/camptocamp/devops-stack-module-keycloak/issues/22)) ([f1ebfff](https://github.com/camptocamp/devops-stack-module-keycloak/commit/f1ebfffa8d6dc22dc296e00cb796eaa68a515dff))

## [2.0.0](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v1.1.1...v2.0.0) (2023-07-11)


### ⚠ BREAKING CHANGES

* add support to oboukili/argocd >= v5 ([#20](https://github.com/camptocamp/devops-stack-module-keycloak/issues/20))

### Features

* add support to oboukili/argocd &gt;= v5 ([#20](https://github.com/camptocamp/devops-stack-module-keycloak/issues/20)) ([e72874f](https://github.com/camptocamp/devops-stack-module-keycloak/commit/e72874ffb3fb45a06c9d8c7c26c03f4c44f6d674))

## [1.1.1](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v1.1.0...v1.1.1) (2023-05-30)


### Bug Fixes

* add default argocd_namespace ([66588ca](https://github.com/camptocamp/devops-stack-module-keycloak/commit/66588cab48b6aba6a702093ca052a2c09114e800))

## [1.1.0](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v1.0.2...v1.1.0) (2023-05-15)


### Features

* **oidc_bootstrap:** add policy scope to authenticate on MinIO module ([#16](https://github.com/camptocamp/devops-stack-module-keycloak/issues/16)) ([b93a756](https://github.com/camptocamp/devops-stack-module-keycloak/commit/b93a756eb8dae54ef297ef02f376cc82bde98a6b))

## [1.0.2](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v1.0.1...v1.0.2) (2023-04-06)


### Bug Fixes

* remove hard curl verison dependency ([#12](https://github.com/camptocamp/devops-stack-module-keycloak/issues/12)) ([d427d9c](https://github.com/camptocamp/devops-stack-module-keycloak/commit/d427d9cba4558c869b14fd2d1e0010118823c781))

## [1.0.1](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v1.0.0...v1.0.1) (2023-03-08)


### Bug Fixes

* change to looser versions constraints as per best practices ([#10](https://github.com/camptocamp/devops-stack-module-keycloak/issues/10)) ([817baef](https://github.com/camptocamp/devops-stack-module-keycloak/commit/817baef75fe267ac958a6dc198b3a0234efa0b97))

## [1.0.0](https://github.com/camptocamp/devops-stack-module-keycloak/compare/v1.0.0-alpha.1...v1.0.0) (2023-02-22)


### Features

* upgrade operator and revamp module ([#6](https://github.com/camptocamp/devops-stack-module-keycloak/issues/6)) ([d8f2232](https://github.com/camptocamp/devops-stack-module-keycloak/commit/d8f223294068aae554929e25fd0046aeadb1cf2f))

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
