import os

from openai import OpenAI


api_key = os.environ.get("SYNAP_API_KEY")
if not api_key:
    raise SystemExit("Set SYNAP_API_KEY before running this example.")

client = OpenAI(
    api_key=api_key,
    base_url=os.environ.get("SYNAP_BASE_URL", "https://pool.linkrra.com/v1"),
)

response = client.chat.completions.create(
    model=os.environ.get("SYNAP_MODEL", "qwen3-coder-30b"),
    messages=[
        {"role": "user", "content": "Reply with exactly: SYNAP_OK"},
    ],
    max_tokens=20,
)

print(response.choices[0].message.content)
