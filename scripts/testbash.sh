#!/bin/bash

# Get dynamic values
HOST=$(hostname)
REMOTE_WRITE_URL="https://daamw-mscycle-8bax.eastus2-1.metrics.ingest.monitor.azure.com/dataCollectionRules/dcr-4304a97b6ad14645b96b56d400a2d151/streams/Microsoft-PrometheusMetrics/api/v1/write?api-version=2023-04-24"
CLIENT_ID="60189e16-60c9-414d-ba88-3306412492ba"

# Start by copying your existing base prometheus.yml (half script you already have)
cp prometheus.yml prometheus3.yml

# Append new scrape jobs
cat <<EOF >> prometheus2.yml

  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9500']
        labels:
          app: "node"
          hostname: "$HOST"

  - job_name: 'gpu'
    static_configs:
      - targets: ['localhost:9400']
        labels:
          app: "gpuapp"
          hostname: "$HOST"
EOF

# Now append remote_write
cat <<EOF >> prometheus2.yml

remote_write:
  - url: "$REMOTE_WRITE_URL"
    azuread:
      cloud: 'AzurePublic'
      managed_identity:
        client_id: "$CLIENT_ID"
EOF

