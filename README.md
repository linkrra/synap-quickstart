# Synap Quickstart

Run an OpenAI-compatible chat completion on Synap with cURL, Python, or Node.js.

Synap is Linkrra's customer-facing inference API. The examples in this repository use the live API at `https://pool.linkrra.com/v1`.

## Prerequisites

- An API key from Synap
- cURL and `jq` for the shell example
- Python 3.10+ for the Python example
- Node.js 20+ for the Node.js example

## 1. Create an API key

1. Open [Synap account → API keys](https://synap.linkrra.com/account.html#keys).
2. Sign in and create a key.
3. Copy it when it appears. The full key is shown once.

Keep the key in an environment variable. Do not paste it into source code:

```bash
export SYNAP_API_KEY="your-key-here"
```

## 2. Make your first request

### cURL

```bash
curl https://pool.linkrra.com/v1/chat/completions \
  -H "Authorization: Bearer $SYNAP_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3-coder-30b",
    "messages": [
      {"role": "user", "content": "Reply with exactly: SYNAP_OK"}
    ],
    "max_tokens": 20
  }'
```

Or run the checked example:

```bash
./examples/curl.sh
```

### Python

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python examples/python.py
```

### Node.js

```bash
npm install
npm run example:node
```

Each example reads these optional environment variables:

- `SYNAP_BASE_URL` — defaults to `https://pool.linkrra.com/v1`
- `SYNAP_MODEL` — defaults to `qwen3-coder-30b`

## Discover available models

The live model catalogue is the source of truth:

```bash
curl -sS https://pool.linkrra.com/v1/models | jq -r '.data[].id'
```

Model availability and prices can change. Check the [live pricing page](https://synap.linkrra.com/pricing.html) before production use.

## Use an existing OpenAI integration

Most OpenAI SDK integrations need only three changes:

```text
base_url = https://pool.linkrra.com/v1
api_key  = your Synap API key
model    = an id returned by /v1/models
```

See the complete [Synap documentation](https://synap.linkrra.com/docs) for streaming, tools, vision, account funding, and error handling.

## Verify this repository

The check script validates all examples and confirms that the public API surfaces are live. When `SYNAP_API_KEY` is set, it also performs a small authenticated inference request.

```bash
./scripts/check.sh
```

## Security and data handling

- Never commit API keys. `.env` files are ignored by this repository.
- Revoke a key from your Synap account if it is exposed.
- Review the current [privacy policy](https://synap.linkrra.com/privacy) before sending sensitive data.

## License

MIT
