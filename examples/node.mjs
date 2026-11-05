import OpenAI from "openai";

if (!process.env.SYNAP_API_KEY) {
  console.error("Set SYNAP_API_KEY before running this example.");
  process.exit(1);
}

const client = new OpenAI({
  apiKey: process.env.SYNAP_API_KEY,
  baseURL: process.env.SYNAP_BASE_URL ?? "https://pool.linkrra.com/v1",
});

const response = await client.chat.completions.create({
  model: process.env.SYNAP_MODEL ?? "qwen3-coder-30b",
  messages: [
    { role: "user", content: "Reply with exactly: SYNAP_OK" },
  ],
  max_tokens: 20,
});

console.log(response.choices[0].message.content);
