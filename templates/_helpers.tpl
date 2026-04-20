{{- /* -------------------------
  singleChart.podLabels
  ------------------------- */ -}}
{{- define "singleChart.podLabels" -}}
{{- with .Values.legacyEvaPodIdentity }}
  {{- if .enabled }}
aadpodidbinding: {{ .bindingName }}
  {{- end }}
{{- end }}
app: {{ .Values.applicationName }}
{{- end }}

{{- /* -------------------------
  singleChart.serviceAccount
  ------------------------- */ -}}
{{- define "singleChart.serviceAccount" -}}
{{- end }}

{{- /* -------------------------
  singleChart.initContainers
  ------------------------- */ -}}
{{- define "singleChart.initContainers" -}}
{{- $init := .Values.initContainers | default dict }}
{{- $mounts := .Values.mounts | default dict }}
{{- $container := .Values.container | default dict }}
{{- $hasInitCurl := false }}
{{- with $init.curl }}
  {{- if .enabled }}
    {{- $hasInitCurl = true }}
  {{- end }}
{{- end }}
{{- $hasInitPostgres := false }}
{{- with $init.postgres }}
  {{- if .enabled }}
    {{- $hasInitPostgres = true }}
  {{- end }}
{{- end }}
{{- $hasInitTelnet := false }}
{{- with $init.telnet }}
  {{- if .enabled }}
    {{- $hasInitTelnet = true }}
  {{- end }}
{{- end }}
{{- $hasInitRedis := false }}
{{- with $init.redis }}
  {{- if .enabled }}
    {{- $hasInitRedis = true }}
  {{- end }}
{{- end }}
{{- $hasInitMongo := false }}
{{- with $init.mongo }}
  {{- if .enabled }}
    {{- $hasInitMongo = true }}
  {{- end }}
{{- end }}
{{- $hasInitOracle := false }}
{{- with $init.oracle }}
  {{- if .enabled }}
    {{- $hasInitOracle = true }}
  {{- end }}
{{- end }}
{{- $hasEmptyDirs := false }}
{{- with $mounts.emptyDirs }}
  {{- if .enabled }}
    {{- $hasEmptyDirs = true }}
  {{- end }}
{{- end }}
{{- $hasPersistentVolumes := false }}
{{- with $mounts.persistentVolumes }}
  {{- if .enabled }}
    {{- $hasPersistentVolumes = true }}
  {{- end }}
{{- end }}
{{- $hasSecretFiles := false }}
{{- with $mounts.secretFiles }}
  {{- if .enabled }}
    {{- $hasSecretFiles = true }}
  {{- end }}
{{- end }}
{{- $hasConfigMapFiles := false }}
{{- with $mounts.configMapFiles }}
  {{- if .enabled }}
    {{- $hasConfigMapFiles = true }}
  {{- end }}
{{- end }}
{{- $hasUseExistingSecret := false }}
{{- with $mounts.useExistingSecret }}
  {{- if .enabled }}
    {{- $hasUseExistingSecret = true }}
  {{- end }}
{{- end }}
{{- if or $hasInitCurl $hasInitPostgres $hasInitTelnet $hasInitRedis $hasInitMongo $hasInitOracle }}
initContainers:
{{- end }}
{{- with $init.curl }}
  {{- if .enabled }}
- name: curl-init-container
  command: {{ tpl .command $ }}
  image: {{ tpl .image $ }}
  imagePullPolicy: IfNotPresent
  {{- end }}
{{- end }}
{{- with $init.postgres }}
  {{- if .enabled }}
- name: postgres-init-container
  command: {{ tpl .command $ }}
  image: {{ tpl .image $ }}
  imagePullPolicy: IfNotPresent
  {{- end }}
{{- end }}
{{- with $init.telnet }}
  {{- if .enabled }}
- name: telnet-init-container
  command: {{ tpl .command $ }}
  image: {{ tpl .image $ }}
  imagePullPolicy: IfNotPresent
  {{- end }}
{{- end }}
{{- with $init.redis }}
  {{- if .enabled }}
- name: redis-init-container
  command: {{ tpl .command $ }}
  image: {{ tpl .image $ }}
  imagePullPolicy: IfNotPresent
  {{- end }}
{{- end }}
{{- with $init.mongo }}
  {{- if .enabled }}
- name: mongo-init-container
  command: {{ tpl .command $ }}
  image: {{ tpl .image $ }}
  imagePullPolicy: IfNotPresent
  {{- end }}
{{- end }}
{{- with $init.oracle }}
  {{- if .enabled }}
- name: oracle-init-container
  command: {{ tpl .command $ }}
  image: {{ tpl .image $ }}
  imagePullPolicy: IfNotPresent
  {{- end }}
{{- end }}
{{- end }}

{{- /* -------------------------
  singleChart.scheduling
  ------------------------- */ -}}
{{- define "singleChart.scheduling" -}}
{{- $mounts := .Values.mounts | default dict }}
{{- $hasPvcItem := false }}
{{- with $mounts.persistentVolumes }}
  {{- if .enabled }}
    {{- range .list }}
      {{- $pvc := .pvc | default dict }}
      {{- if $pvc.enabled }}
        {{- $hasPvcItem = true }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- if $hasPvcItem }}
schedulerName: "default-scheduler"
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- with .Values.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{- /* -------------------------
  singleChart.container
  ------------------------- */ -}}
{{- define "singleChart.container" -}}
{{- $init := .Values.initContainers | default dict }}
{{- $mounts := .Values.mounts | default dict }}
{{- $container := .Values.container | default dict }}
{{- $hasInitCurl := false }}
{{- with $init.curl }}
  {{- if .enabled }}
    {{- $hasInitCurl = true }}
  {{- end }}
{{- end }}
{{- $hasInitPostgres := false }}
{{- with $init.postgres }}
  {{- if .enabled }}
    {{- $hasInitPostgres = true }}
  {{- end }}
{{- end }}
{{- $hasInitTelnet := false }}
{{- with $init.telnet }}
  {{- if .enabled }}
    {{- $hasInitTelnet = true }}
  {{- end }}
{{- end }}
{{- $hasInitRedis := false }}
{{- with $init.redis }}
  {{- if .enabled }}
    {{- $hasInitRedis = true }}
  {{- end }}
{{- end }}
{{- $hasInitMongo := false }}
{{- with $init.mongo }}
  {{- if .enabled }}
    {{- $hasInitMongo = true }}
  {{- end }}
{{- end }}
{{- $hasInitOracle := false }}
{{- with $init.oracle }}
  {{- if .enabled }}
    {{- $hasInitOracle = true }}
  {{- end }}
{{- end }}
{{- $hasEmptyDirs := false }}
{{- with $mounts.emptyDirs }}
  {{- if .enabled }}
    {{- $hasEmptyDirs = true }}
  {{- end }}
{{- end }}
{{- $hasPersistentVolumes := false }}
{{- with $mounts.persistentVolumes }}
  {{- if .enabled }}
    {{- $hasPersistentVolumes = true }}
  {{- end }}
{{- end }}
{{- $hasSecretFiles := false }}
{{- with $mounts.secretFiles }}
  {{- if .enabled }}
    {{- $hasSecretFiles = true }}
  {{- end }}
{{- end }}
{{- $hasConfigMapFiles := false }}
{{- with $mounts.configMapFiles }}
  {{- if .enabled }}
    {{- $hasConfigMapFiles = true }}
  {{- end }}
{{- end }}
{{- $hasUseExistingSecret := false }}
{{- with $mounts.useExistingSecret }}
  {{- if .enabled }}
    {{- $hasUseExistingSecret = true }}
  {{- end }}
{{- end }}

{{- /* Mutual exclusivity validation for persistentVolumes items */}}
{{- with .Values.mounts }}
  {{- with .persistentVolumes }}
    {{- if .enabled }}
      {{- range .list }}
        {{- $pvPvc := .pvc | default dict }}
        {{- $pvAzure := .azureFileShareOrBlob | default dict }}
        {{- if and $pvPvc.enabled $pvAzure.enabled }}
          {{- fail (printf "persistentVolumes item '%s': only one of pvc.enabled or azureFileShareOrBlob.enabled can be true" .name) }}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{- $envCfg := .Values.environmentVariablesViaConfigMap }}
{{- if and $envCfg $envCfg.enabled }}
envFrom:
  - configMapRef:
      name: {{ $.Values.applicationName }}-configmap
{{- end }}
securityContext:
  runAsNonRoot: true
  runAsUser: {{ default 1000 .Values.runAsUser }}
  runAsGroup: {{ default 1000 .Values.runAsGroup }}
  allowPrivilegeEscalation: false
  privileged: false
  readOnlyRootFilesystem: true
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    drop: ["ALL"]
imagePullPolicy: {{ default "IfNotPresent" .Values.appImagePullPolicy }}
{{- if .Values.image }}
image: "{{ tpl .Values.image.repository . }}:{{ .Values.image.tag }}"
{{- else if .Values.imageName }}
image: "{{ tpl .Values.imageName . }}"
{{- else }}
image: ""
{{- end }}
{{- with $container.startCommand }}
  {{- if .enabled }}
command: {{ tpl .command $ }}
  {{- end }}
{{- end }}
{{- with $container.startCommandArgs }}
  {{- if .enabled }}
args: {{ tpl .args $ }}
  {{- end }}
{{- end }}
lifecycle:
  postStart:
    exec:
{{- with $container.lifecycle }}
  {{- with .postStart }}
    {{- if .enabled }}
      command: {{ tpl .command $ }}
    {{- else }}
      command: ["/bin/sh", "-c", "echo"]
      #echo
    {{- end }}
  {{- end }}
  {{- with .preStop }}
  preStop:
    exec:
    {{- if .enabled }}
      command: {{ tpl .command $ }}
    {{- else }}
      command: ["/bin/sh", "-c", "echo"]
    {{- end }}
  {{- end }}
{{- end }}
{{- with $container.livenessProbe }}
  {{- if .enabled }}
livenessProbe:
  httpGet:
   {{- with .customHeaders }}
     httpHeaders:
     - name: {{ .name }}
       value: "{{ .value }}"
   {{- end }}
     path: {{ .selfHealthCheckUrl }}
     port: {{ $.Values.ports }}
     scheme: {{ .scheme }}
  timeoutSeconds: 10
  periodSeconds: 60
  successThreshold: 1
  failureThreshold: 1
  {{- end }}
{{- end }}

{{- with $container.startupProbe }}
  {{- if .enabled }}
startupProbe:
  httpGet:
   {{- with .customHeaders }}
     httpHeaders:
     - name: {{ .name }}
       value: "{{ .value }}"
   {{- end }}
     path: {{ .selfHealthCheckUrl }}
     port: {{ $.Values.ports }}
     scheme: {{ .scheme }}
  timeoutSeconds: 10
  periodSeconds: 60
  successThreshold: 1
  failureThreshold: 3
  {{- end }}
{{- end }}

{{- with $container.readinessProbe }}
  {{- if .enabled }}
readinessProbe:
  httpGet:
   {{- with .customHeaders }}
     httpHeaders:
     - name: {{ .name }}
       value: "{{ .value }}"
   {{- end }}
     path: {{ .selfHealthCheckUrl }}
     port: {{ $.Values.ports }}
     scheme: {{ .scheme }}
  timeoutSeconds: 10
  periodSeconds: 60
  successThreshold: 1
  failureThreshold: 3
  {{- end }}
{{- end }}
{{- if .Values.ports }}
ports:
  - containerPort: {{ .Values.ports }}
    protocol: "TCP"
{{- end }}
resources:
  limits:
    cpu: {{ tpl .Values.maxCPUCores . }}
    memory: {{ tpl .Values.maxMemory . }}
  requests:
    cpu: {{ tpl .Values.minCPUCores . }}
    memory: {{ tpl .Values.minMemory . }}
{{- if or $hasSecretFiles $hasPersistentVolumes $hasConfigMapFiles $hasEmptyDirs $hasUseExistingSecret }}
volumeMounts:
{{- end }}
{{- if $hasEmptyDirs }}
  {{- range $key, $value := .Values.mounts.emptyDirs.list }}
  - mountPath: {{ tpl $value $ }}
    name: {{ tpl $key $ }}
  {{- end }}
{{- end }}
{{- if $hasSecretFiles }}
{{- range $smount := .Values.mounts.secretFiles.list }}
  {{- $resolvedPath := tpl $smount.path $ }}
  {{- if not $resolvedPath }}
    {{- fail (printf "mounts.secretFiles entry '%s' has an empty path. Set .Values.secretVolumePath or provide a literal path." $smount.name) }}
  {{- end }}
  - mountPath: {{ $resolvedPath }}
    {{- if $smount.subPath }}
      subPath: {{ tpl $smount.subPath $ }}
    {{- end }}
    name: {{ $.Values.applicationName }}{{ $smount.name }}secretfiles
{{- end }}
{{- end }}
{{- if $hasUseExistingSecret }}
{{- with .Values.mounts.useExistingSecret }}
  {{- range $esvmount := .list }}
  - mountPath: {{ tpl $esvmount.path $ }}
    {{- if $esvmount.subPath }}
      subPath: {{ tpl $esvmount.subPath $ }}
    {{- end }}
    name: {{ $esvmount.name }}
  {{- end }}
{{- end }}
{{- end }}
{{- if $hasPersistentVolumes }}
  {{- range $pv := .Values.mounts.persistentVolumes.list }}
    {{- $pvPvc := $pv.pvc | default dict }}
    {{- $pvAfs := $pv.azureFileShareOrBlob | default dict }}
    {{- if or $pvPvc.enabled $pvAfs.enabled }}
  - mountPath: {{ tpl $pv.path $ }}
    name: {{ tpl $pv.name $ }}
    readOnly: {{ $pv.readOnly | default false }}
      {{- with $pv.subPath }}
    subPath: {{ tpl . $ }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- if $hasConfigMapFiles }}
{{- range $cmount := .Values.mounts.configMapFiles.list }}
  - mountPath: {{ tpl $cmount.path $ }}
  {{- if $cmount.subPath }}
    subPath: {{ tpl $cmount.subPath $ }}
  {{- end }}
    name: {{ $.Values.applicationName }}{{ $cmount.name }}configmapfiles
{{- end }}
{{- end }}
{{- end }}

{{- /* -------------------------
  singleChart.volumes
  ------------------------- */ -}}
{{- define "singleChart.volumes" -}}
{{- $mounts := .Values.mounts | default dict }}
{{- $hasEmptyDirs := false }}
{{- with $mounts.emptyDirs }}
  {{- if .enabled }}
    {{- $hasEmptyDirs = true }}
  {{- end }}
{{- end }}
{{- $hasPersistentVolumes := false }}
{{- with $mounts.persistentVolumes }}
  {{- if .enabled }}
    {{- $hasPersistentVolumes = true }}
  {{- end }}
{{- end }}
{{- $hasSecretFiles := false }}
{{- with $mounts.secretFiles }}
  {{- if .enabled }}
    {{- $hasSecretFiles = true }}
  {{- end }}
{{- end }}
{{- $hasConfigMapFiles := false }}
{{- with $mounts.configMapFiles }}
  {{- if .enabled }}
    {{- $hasConfigMapFiles = true }}
  {{- end }}
{{- end }}
{{- $hasUseExistingSecret := false }}
{{- with $mounts.useExistingSecret }}
  {{- if .enabled }}
    {{- $hasUseExistingSecret = true }}
  {{- end }}
{{- end }}
{{- if or $hasSecretFiles $hasPersistentVolumes $hasConfigMapFiles $hasEmptyDirs $hasUseExistingSecret }}
volumes:
{{- end }}
{{- if $hasEmptyDirs }}
  {{- range $key, $value := .Values.mounts.emptyDirs.list }}
- name: {{ tpl $key $ }}
  emptyDir:
    sizeLimit: {{ $.Values.mounts.emptyDirs.sizeLimit }}
  {{- end }}
{{- end }}
{{- if $hasSecretFiles }}
{{- range $smount := .Values.mounts.secretFiles.list }}
- name: {{ $.Values.applicationName }}{{ $smount.name }}secretfiles
  secret:
    secretName: {{ $.Values.applicationName }}-{{ $smount.name }}-secretfiles
{{- end }}
{{- end }}
{{- if $hasUseExistingSecret }}
{{- with .Values.mounts.useExistingSecret }}
  {{- range $esmount := .list }}
- name: {{ $esmount.name }}
  secret:
    secretName: {{ tpl $esmount.secretName $ }}
  {{- end }}
{{- end }}
{{- end }}
{{- if $hasPersistentVolumes }}
  {{- range $pv := .Values.mounts.persistentVolumes.list }}
    {{- $pvPvc := $pv.pvc | default dict }}
    {{- $pvAzure := $pv.azureFileShareOrBlob | default dict }}
    {{- if $pvPvc.enabled }}
- name: {{ tpl $pv.name $ }}
  persistentVolumeClaim:
    claimName: {{ tpl $pv.name $ }}
    {{- else if $pvAzure.enabled }}
- name: {{ tpl $pv.name $ }}
  persistentVolumeClaim:
{{- if eq ($pvAzure.type | default "") "StorageConfigFile" }}
    claimName: {{ tpl $pv.name $ }}-{{ $pvAzure.shareOrContainerName }}-file-pvc
{{- else if eq ($pvAzure.type | default "") "StorageConfigBlob" }}
    claimName: {{ tpl $pv.name $ }}-{{ $pvAzure.shareOrContainerName }}-blob-pvc
{{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- if $hasConfigMapFiles }}
{{- range $cmount := .Values.mounts.configMapFiles.list }}
- name: {{ $.Values.applicationName }}{{ $cmount.name }}configmapfiles
  configMap:
    name: {{ $.Values.applicationName }}-{{ $cmount.name }}-configmapfiles
{{- end }}
{{- end }}
{{- end }}


{{- /* -------------------------
  podSecurityContext Outputs pod-level securityContext
  ------------------------- */ -}}
{{- define "singleChart.podSecurityContext" -}}
securityContext:
  fsGroup: {{ default 1000 .Values.runAsUser }}
  fsGroupChangePolicy: OnRootMismatch
{{- end }}
