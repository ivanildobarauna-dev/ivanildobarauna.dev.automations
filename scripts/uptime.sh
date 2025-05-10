#!/bin/bash

# Uptime da VPS (dias, horas, minutos)
VPS_UPTIME=$(awk '{print int($1/86400)"d "int(($1%86400)/3600)"h "int(($1%3600)/60)"m"}' /proc/uptime)

# Lista todos os containers com nome e estado
ALL_CONTAINERS=$(docker ps -a --format '{{.Names}} {{.State}}')

# Cabeçalho
echo "🔧 Uptime e Healthcheck do Sistema:"
echo "🕒 VPS ativa há: ${VPS_UPTIME}"
echo "📦 Status dos Containers:"

# Loop nos containers
echo "$ALL_CONTAINERS" | while read -r line; do
  CONTAINER_NAME=$(echo "$line" | awk '{print $1}')
  CONTAINER_STATE=$(echo "$line" | awk '{print $2}')

  if [ "$CONTAINER_STATE" = "running" ]; then
    STATUS="🟢 Running"
  else
    STATUS="🔴 Stopped"
  fi

  echo "  🔹 $CONTAINER_NAME — $STATUS"
done
