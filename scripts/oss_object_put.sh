#!/usr/bin/env bash
set -euo pipefail

LOCAL_FILE="${1:?local file path required}"
BUCKET_NAME="${2:?bucket name required}"
OBJECT_NAME="${3:?object name (key) in bucket required}"

[ -f "${LOCAL_FILE}" ] || { echo "File not found: ${LOCAL_FILE}" >&2; exit 1; }

NAMESPACE="${OS_NAMESPACE:-}"
[ -n "${NAMESPACE}" ] || NAMESPACE="$(oci os ns get --query data --raw-output)"

echo "Uploading bucket=${BUCKET_NAME} object=${OBJECT_NAME} namespace=${NAMESPACE}"

oci os object put \
  --namespace-name "${NAMESPACE}" \
  --bucket-name "${BUCKET_NAME}" \
  --name "${OBJECT_NAME}" \
  --file "${LOCAL_FILE}" \
  --force

echo "Upload complete."
