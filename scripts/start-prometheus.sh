#!/bin/bash

if grep -q "remote_write:" prometheus2.yml 2>/dev/null; then
    echo "[INFO] prometheus2.yml already contains remote_write block. Skipping prometheus-append-handler.sh."
else
    echo "[INFO] prometheus2.yml does NOT contain remote_write block. Running prometheus-append-handler.sh..."
    ./prometheus-append-handler.sh

    # Check if prometheus2.yml was generated
    if [ ! -f prometheus2.yml ]; then
        echo "[ERROR] prometheus2.yml was not generated! Exiting."
        exit 1
    fi
fi

echo "[INFO] Starting Prometheus with prometheus2.yml config..."
./prometheus --config.file=prometheus2.yml &

PROM_PID=$!
echo "[INFO] Prometheus started with PID $PROM_PID."
