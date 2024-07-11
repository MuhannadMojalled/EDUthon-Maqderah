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


def generate_advice(clo):
    # Generate the audio advice
    prompt = f"""The student has difficulties in the following Course Learning Outcomes (CLOs) or topics:

{clo}

Provide detailed advice on how the student can improve their understanding and performance in these specific topics. Include strategies for studying, practice recommendations, and any useful resources or tips.
"""
    completion = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a teacher"},
            {"role": "user", "content": prompt},
        ],
        max_tokens=max_tokens,
        temperature=temperature,
    )
    advice = completion.choices[0].message.content
    advice = (
        advice.replace("**", "")
        .replace("**", "")
        .replace("###", "")
        .replace("##", "")
        .replace("#", "")
        .replace("Certainly!", "")
    )
    return advice


def generate_advice_audio(clo):
    # Generate the audio advice
    prompt = f"the student took a quiz, and answerd some questions wrong, this is the Course Learning Outcome (CLO) of the questions that he answered wrong: {clo} based on that, explain very briefly it to the student, and briefly give advice on how to improve his level in these topics."
    completion = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a teacher"},
            {"role": "user", "content": prompt},
        ],
        max_tokens=max_tokens,
        temperature=temperature,
    )
    return audio_handle.audio_handler(
        completion.choices[0].message.content, "advice.mp3"
    )


def get_videos(clo):
    # Generate the audio advice
    prompt = f"""The student has difficulties in the following Course Learning Outcomes (CLOs) or topics: {clo}
based on that,Provide new youtube videos link that give them advice on how the student can improve their understanding and performance in these specific topics. Include vidoes of strategies for studying, vidoes practice recommendations, and any useful resources or tips.
 just give me three youtube videos that can help the student understand this {clo}. no test just three links I need nothing but the links url, give it to me in a json format, do not send anything except the links. format the links like this:
1. URL
2. URL
3. URL"""
    completion = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a teacher"},
            {"role": "user", "content": prompt},
        ],
        max_tokens=max_tokens,
        temperature=temperature,
    )

    response = completion.choices[0].message.content
    response = response.replace("json", "").replace("```", "")
    # Parse the JSON response
    data = json.loads(response)

    # Extract the links
    links = [data[key] for key in data]

    # Creating the JSON structure
    data = {"links": links}
    return data
