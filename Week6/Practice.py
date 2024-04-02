from openai import OpenAI

client = OpenAI(api_key="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")

response = client.chat.completions.create(
  model="gpt-4-vision-preview",
  messages=[
    {
      "role": "user",
      "content": [
        {"type": "text", "text": "使用繁體中文說明這圖在說什麼"},
        {
          "type": "image_url",
          "image_url": {
            "url": "https://tpemartin.github.io/my graph/practice graph.png"  },
        },
      ],
    }
  ],
  max_tokens=300,
)

print(response.choices[0])

