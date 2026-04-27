#!/bin/bash
set -euo pipefail

POD=$(kubectl get pods -o name | grep '^pod/mysql-' | head -n1 | cut -d/ -f2)

if [ -z "$POD" ]; then
  echo "ERROR: MySQL pod not found"
  exit 1
fi

RESULT=$(kubectl exec -i "$POD" -- \
mysql -u root -psecret -N -s -e "
SELECT COLUMN_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbook'
  AND TABLE_NAME = 'Authors'
  AND COLUMN_NAME = 'name';
")

echo "Тип поля Authors.name: $RESULT"

if [ "$RESULT" = "varchar(50)" ]; then
  echo "OK: Authors.name имеет тип varchar(50)"
else
  echo "ERROR: Authors.name должен быть varchar(50), а найден '$RESULT'"
  exit 1
fi
