#!/bin/bash

# CPU (uso total em %)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

# RAM (uso em %)
MEM_USAGE=$(free | awk '/Mem:/ { printf("%.2f"), $3/$2 * 100 }')

# Disco (uso em % da partição raiz)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# Containers Docker em execução
DOCKER_CONTAINERS=$(docker ps -q | wc -l)

# Exibe o resultado formatado
echo "🔧 Status do Sistema:"
echo "🖥️ CPU usada: ${CPU_USAGE}%"
echo "📈 RAM usada: ${MEM_USAGE}%"
echo "💽 Disco usado: ${DISK_USAGE}%"
echo "📦 Containers Docker ativos: ${DOCKER_CONTAINERS}"
