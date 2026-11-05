#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

echo "Checking example syntax..."
bash -n examples/curl.sh scripts/check.sh
python3 -m py_compile examples/python.py
node --check examples/node.mjs

echo "Checking for accidentally committed secret-shaped values..."
if grep -RInE \
  --exclude-dir=.git \
  --exclude-dir=node_modules \
  --exclude='*.pyc' \
  'sk-(live|test|pool)-[A-Za-z0-9_-]{12,}|gh[pousr]_[A-Za-z0-9]{20,}' .; then
  echo "Potential credential found." >&2
  exit 1
fi

echo "Checking live Synap surfaces..."
curl --fail --silent --show-error https://pool.linkrra.com/v1/models \
  | jq -e '.data | any(.id == "qwen3-coder-30b")' >/dev/null
curl --fail --silent --show-error https://synap.linkrra.com/account.html >/dev/null
curl --fail --silent --show-error https://synap.linkrra.com/docs >/dev/null

if [[ -n "${SYNAP_API_KEY:-}" ]]; then
  echo "Running a small authenticated inference request..."
  result="$(./examples/curl.sh)"
  if [[ -z "${result}" ]]; then
    echo "The inference response was empty." >&2
    exit 1
  fi
  echo "Authenticated inference passed: ${result}"
else
  echo "SYNAP_API_KEY is not set; authenticated inference was skipped."
fi

echo "All available checks passed."
