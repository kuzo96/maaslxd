{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/*
Create a default fully qualified app name.
We truncate at  63 | trimSuffix "-" chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "mariadb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mariadb" | trunc  63 | trimSuffix "-" -}}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "common.capabilities.deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{- define "common.capabilities.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- end -}}

{{/*
Return  the proper Storage Class
*/}}
{{- define "librenms.storageClass" -}}
{{- include "common.storage.class" (dict "persistence" .Values.persistence "global" .Values.global) -}}
{{- end -}}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "base.labels" -}}
helm.sh/chart: {{ include "chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "labels" -}}
{{ include "base.labels" . }}
{{ include "selectorLabels" . }}
{{- end }}

{{/*
  NOTE: Not including changing fields such as
  "version" and "chart" in "app" due to bug StatefulSet
  cannot be updated if using PVC and changing labels.
  helm/charts issue #7803
*/}}
{{- define "app.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "app.selectorLabels" . }}
{{- end }}

{{- define "poller.labels" -}}
{{ include "base.labels" . }}
{{ include "poller.selectorLabels" . }}
{{- end }}

{{- define "syslog.labels" -}}
{{ include "base.labels" . }}
{{ include "syslog.selectorLabels" . }}
{{- end }}

{{- define "rrdcached.labels" -}}
{{ include "base.labels" . }}
{{ include "rrdcached.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "selectorLabels" -}}
app.kubernetes.io/name: {{ include "name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "app.selectorLabels" -}}
{{ include "selectorLabels" . }}
app.kubernetes.io/component: app
{{- end }}
{{- define "poller.selectorLabels" -}}
{{ include "selectorLabels" . }}
app.kubernetes.io/component: poller
{{- end }}
{{- define "syslog.selectorLabels" -}}
{{ include "selectorLabels" . }}
app.kubernetes.io/component: syslog
{{- end }}
{{- define "rrdcached.selectorLabels" -}}
{{ include "selectorLabels" . }}
app.kubernetes.io/component: rrdcached
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Define the common environment variables for LibreNMS app
*/}}
{{- define "environment_ref_default" -}}
- secretRef:
    name: {{ include "fullname" . }}-env
- configMapRef:
    name: {{ include "fullname" . }}-env
{{- end }}
