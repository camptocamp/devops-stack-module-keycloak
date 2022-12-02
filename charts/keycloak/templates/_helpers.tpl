{{/* Create chart name and version to be used by the chart label */}}
{{- define "devops-stack-module-keycloak.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{ end -}}

{{/* Compute hash of the the configuration passed to define the links inside the static page */}}
{{- define "devops-stack-module-keycloak-configmap.checksum" }}
{{- tpl ($.Files.Get "helloworld_hyperlinks_configmap.yaml") $ | sha256sum | trunc 14 -}}
{{ end -}}

{{/* Define selectors to be used (to be also used as templates) */}}
{{- define "devops-stack-module-keycloak.selector" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{ end -}}

{{/* Define common labels */}}
{{- define "devops-stack-module-keycloak.labels" -}}
{{ include "devops-stack-module-keycloak.selector" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{ end -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "devops-stack-module-keycloak.chart" . }}
helloworld-configmap-hash: {{ include "devops-stack-module-keycloak-configmap.checksum" . }}
{{- end -}}
{{/* End labels */}}
