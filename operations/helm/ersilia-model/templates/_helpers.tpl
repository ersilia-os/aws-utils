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
memory: 1.2Gi
{{- else if eq .modelSize "2Gi" }}
memory: 2.2Gi
{{- else if eq .modelSize "3Gi" }}
memory: 3.2Gi
{{- else if eq .modelSize "4Gi" }}
memory: 4.3Gi
{{- else if eq .modelSize "5Gi" }}
memory: 5.3Gi
{{- else if eq .modelSize "6Gi" }}
memory: 6.4Gi
{{- end }}
{{- end }}

# TODO: add memory label to node pools and update these
{{- define "lib.modelSize.nodeLabelsLookup" }}
{{- if eq .modelSize "500Mi" }}
- worker-node-1
{{- else if eq .modelSize "1Gi" }}
- worker-node-1
{{- else if eq .modelSize "2Gi" }}
- worker-node-1
{{- else if eq .modelSize "3Gi" }}
- worker-node-1
{{- else if eq .modelSize "4Gi" }}
- worker-node-1
{{- else if eq .modelSize "5Gi" }}
- worker-node-1
{{- else if eq .modelSize "6Gi" }}
- worker-node-1
{{- end }}
{{- end }}