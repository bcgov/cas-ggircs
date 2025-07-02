{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cas-ggircs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cas-ggircs.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cas-ggircs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cas-ggircs.labels" -}}
helm.sh/chart: {{ include "cas-ggircs.chart" . }}
{{ include "cas-ggircs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cas-ggircs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cas-ggircs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cas-ggircs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cas-ggircs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Gets the suffix of the namespace. (dev, tools, ... )
*/}}
{{- define "cas-ggircs.namespaceSuffix" }}
{{- (split "-" .Release.Namespace)._1 | trim -}}
{{- end }}

{{/*
Define environment variables for database cluster connection
*/}}
{{- define "cas-ggircs.databaseEnvVars.ggircsUser" -}}
- name: PGUSER
  value: null
  valueFrom:
    secretKeyRef:
      key: user
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-{{ .Values.database.user}}
- name: PGPASSWORD
  value: null
  valueFrom:
    secretKeyRef:
      key: password
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-{{ .Values.database.user}}
- name: PGDATABASE
  value: null
  valueFrom:
    secretKeyRef:
      key: dbname
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-{{ .Values.database.user}}
- name: PGPORT
  value: null
  valueFrom:
    secretKeyRef:
      key: pgbouncer-port
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-{{ .Values.database.user}}
- name: PGHOST
  value: null
  valueFrom:
    secretKeyRef:
      key: pgbouncer-host
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-{{ .Values.database.user}}
{{- end }}

{{/*
Define environment variables for database cluster connection
*/}}
{{- define "cas-ggircs.databaseEnvVars.postgresUser" -}}
- name: PGUSER
  value: null
  valueFrom:
    secretKeyRef:
      key: user
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-postgres
- name: PGPASSWORD
  value: null
  valueFrom:
    secretKeyRef:
      key: password
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-postgres
- name: PGPORT
  value: null
  valueFrom:
    secretKeyRef:
      key: port
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-postgres
- name: PGHOST
  value: null
  valueFrom:
    secretKeyRef:
      key: host
      name: {{ .Values.database.releaseName }}-{{ .Values.database.chartName }}-pguser-postgres
{{- end }}
