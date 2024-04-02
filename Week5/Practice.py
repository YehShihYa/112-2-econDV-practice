from openai import OpenAI

client = OpenAI(api_key = "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")

response = client.chat.completions.create(
  model="gpt-4-vision-preview",
  messages=[
    {
      "role": "user",
      "content": [
        {"type": "text", "text": "What’s in this image?"},
        {
          "type": "image_url",
          "image_url": {
            "url": "https://www.economist.com/cdn-cgi/image/width=360,quality=80,format=auto/content-assets/images/20240323_EPC824.png"
          },
        },
      ],
    }
  ],
  max_tokens=300,
)

print(response.choices[0])
