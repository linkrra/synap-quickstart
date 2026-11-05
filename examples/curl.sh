#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${SYNAP_API_KEY:-}" ]]; then
  echo "Set SYNAP_API_KEY before running this example." >&2
  exit 1
fi

synap_base_url="${SYNAP_BASE_URL:-https://pool.linkrra.com/v1}"
synap_model="${SYNAP_MODEL:-qwen3-coder-30b}"

curl --fail-with-body --silent --show-error \
  "${synap_base_url}/chat/completions" \
  -H "Authorization: Bearer ${SYNAP_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg model "${synap_model}" \
    '{
      model: $model,
      messages: [{role: "user", content: "Reply with exactly: SYNAP_OK"}],
      max_tokens: 20
    }')" \
  | jq -r '.choices[0].message.content'
