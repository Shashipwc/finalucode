#!/usr/bin/env bash
set -euo pipefail

BUCKET_NAME="${1:?bucket name required}"
OBJECT_NAME="${2:?object name (key) in bucket required}"
LOCAL_FILE="${3:?local file path required}"

NAMESPACE="${OS_NAMESPACE:-}"
[ -n "${NAMESPACE}" ] || NAMESPACE="$(oci os ns get --query data --raw-output)"

mkdir -p "$(dirname "${LOCAL_FILE}")"

echo "Downloading bucket=${BUCKET_NAME} object=${OBJECT_NAME} namespace=${NAMESPACE}"

oci os object get \
  --namespace-name "${NAMESPACE}" \
  --bucket-name "${BUCKET_NAME}" \
  --name "${OBJECT_NAME}" \
  --file "${LOCAL_FILE}"

echo "Download complete: ${LOCAL_FILE}"
