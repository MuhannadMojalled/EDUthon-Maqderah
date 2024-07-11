import os
import json
from openai import OpenAI
from dotenv import load_dotenv, find_dotenv
import audio_handle

# load environment variables
_ = load_dotenv(find_dotenv())
client = OpenAI(
    api_key=os.getenv("OPENAI_API_KEY"),
)

model = "gpt-4o"
temperature = 0.3
max_tokens = 500


def generate_audio(text):
    prompt = f"the student took a quiz, and answerd some questions wrong, this is the Course Learning Outcome (CLO) of the questions that he answered wrong: {text} based on that, explain very briefly it to the student, and give advice on how to improve his level."
    completion = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a teacher"},
            {"role": "user", "content": prompt},
        ],
        max_tokens=max_tokens,
        temperature=temperature,
    )
    audio_handle.audio_handler(completion.choices[0].message.content, "advice.mp3")
