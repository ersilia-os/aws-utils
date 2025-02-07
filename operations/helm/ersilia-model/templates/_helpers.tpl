{{- define "lib.common.labels" }}
app.kubernetes.io/name: {{ .modelCollectionName }}-model
app.kubernetes.io/component: model
app.kubernetes.io/part-of: {{ .modelCollectionName }}
{{- end }}

{{- define "lib.common.selector" }}
app.kubernetes.io/name: {{ .modelCollectionName }}-model
{{- end }}