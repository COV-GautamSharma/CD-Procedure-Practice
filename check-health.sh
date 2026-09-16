#!/bin/sh
set -e

COMPOSE_FILE="${1:-docker-compose.new.yml}"
CONTAINERS="backend frontend"

for cont in $CONTAINERS; do
  cid=$(docker compose -f "$COMPOSE_FILE" ps -q "$cont")

  if [ -z "$cid" ]; then
    echo "$cont: container is not found"
    exit 1
  fi

  status=$(docker inspect --format='{{.State.Health.Status}}' "$cid" 2>/dev/null || echo "none")

  if [ "$status" != "healthy" ]; then
    echo "$cont: status is '$status'.Was expecting healthy container"
    exit 1
  fi

  echo "$cont: The container is healthy"
done

exit 0