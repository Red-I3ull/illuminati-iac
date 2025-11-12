replicaCount: ${frontend_replicas}

image:
  repository: ${frontend_image_repository}
  pullPolicy: Always
  tag: "${frontend_image_tag}"


podAnnotations: {}

service:
  type: ClusterIP
  port: 8080
  targetPort: 8080

containerPort: 8080

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 100m
    memory: 128Mi

autoscaling:
  enabled: true
  minReplicas: 1
  maxReplicas: 2
  targetCPUUtilizationPercentage: 70

existingSecret: ""

