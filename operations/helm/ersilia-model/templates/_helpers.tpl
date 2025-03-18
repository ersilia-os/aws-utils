{{- define "lib.common.labels" }}
app.kubernetes.io/name: {{ .modelCollectionName }}-model
app.kubernetes.io/component: model
app.kubernetes.io/part-of: {{ .modelCollectionName }}-models
{{- end }}

{{- define "lib.common.selector" }}
app.kubernetes.io/name: {{ .modelCollectionName }}-model
{{- end }}

{{- define "lib.modelSize.limitLookup" }}
{{- if eq .modelSize "500Mi" }}
memory: 700Mi
{{- else if eq .modelSize "1Gi" }}
memory: 1200Mi
{{- else if eq .modelSize "2Gi" }}
memory: 2200Mi
{{- else if eq .modelSize "3Gi" }}
memory: 3200Mi
{{- else if eq .modelSize "4Gi" }}
memory: 4300Mi
{{- else if eq .modelSize "5Gi" }}
memory: 5300Mi
{{- else if eq .modelSize "6Gi" }}
memory: 6400Mi
{{- end }}
{{- end }}

{{- define "lib.modelSize.nodeLabelsLookup" }}
{{- if eq .modelSize "500Mi" }}
- 500Mi
- 1Gi
- 2Gi
- 4Gi
- 8Gi
{{- else if eq .modelSize "1Gi" }}
- 1Gi
- 2Gi
- 4Gi
- 8Gi
{{- else if eq .modelSize "2Gi" }}
- 2Gi
- 4Gi
- 8Gi
{{- else if eq .modelSize "3Gi" }}
- 4Gi
- 8Gi
{{- else if eq .modelSize "4Gi" }}
- 4Gi
- 8Gi
{{- else if eq .modelSize "5Gi" }}
- 8Gi
{{- else if eq .modelSize "6Gi" }}
- 8Gi
{{- end }}
{{- end }}