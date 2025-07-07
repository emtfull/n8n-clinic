# export_workflows.sh
#!/usr/bin/env bash

# Export n8n workflows to a timestamped folder
set -euo pipefail

if ! command -v docker &> /dev/null; then
  echo "❌ Docker not found. Please install Docker first."
  exit 1
fi

if [ -z "${N8N_ENCRYPTION_KEY:-}" ]; then
  echo "❌ N8N_ENCRYPTION_KEY is required but not set."
  exit 1
fi

EXPORT_DIR="${1:-n8n-export-$(date +%Y%m%d-%H%M%S)}"
DATA_FOLDER="${DATA_FOLDER:-/home/node/.n8n}"
BACKUP_ROOT="${BACKUP_ROOT:-/backup}"

export GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-UTC}"
export TZ="${TZ:-UTC}"

echo "🚀 Starting n8n workflow export..."
echo "📦 Export directory: $EXPORT_DIR"
echo "📁 Data folder: $DATA_FOLDER"

mkdir -p "$BACKUP_ROOT"

# Export workflows
docker run --rm \
  -v "$DATA_FOLDER:/home/node/.n8n:ro" \
  -v "$BACKUP_ROOT:/backup" \
  -e N8N_ENCRYPTION_KEY \
  -e GENERIC_TIMEZONE \
  -e TZ \
  -u node \
  n8nio/n8n:latest \
  n8n export:workflow --backup --output="/backup/$EXPORT_DIR/" --data="/home/node/.n8n"

tar -czf "$BACKUP_ROOT/$EXPORT_DIR.tar.gz" -C "$BACKUP_ROOT" "$EXPORT_DIR"
echo "✅ Workflows exported to: $BACKUP_ROOT/$EXPORT_DIR.tar.gz"

---
