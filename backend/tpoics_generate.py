import json
import os
from openai import OpenAI
from dotenv import load_dotenv, find_dotenv
import pdf_handler
import output_handler


def generateQuestionsTopic(text):
    output_json_path = "output_questions.json"
    # load environment variables
    _ = load_dotenv(find_dotenv())
    client = OpenAI(
        api_key=os.getenv("OPENAI_API_KEY"),
    )

    model = "gpt-4o"
    temperature = 0.3
    max_tokens = 1000

    # generate multiple-choice questions
    def generate_mcqs(text, num_questions=10):
        prompt = (
            f"Create {num_questions} multiple-choice questions, and choose a Course Learning Outcome (CLOs) for each question based on the question and I want you to use only three different CLOs, also assign each question a difficulty between 1 and 3, 3 being the hardest. only using the following topic:\n\n{text}\n\nFormat: Questions,the the questions and four options (A, B, C, D), and the correct answer as the letter (A, B, C, D), and the CLO, and a difficulty as a number in range of 3."
            + """format it in this way 
### Questions

1. **What is the primary goal of cluster analysis?**
   - A. To classify data based on predefined labels
   - B. To find groups of objects that are similar to each other
   - C. To segment data alphabetically
   - D. To partition graphs
   - **Correct Answer:** B
   - **CLO:** Understand the basic concepts and techniques of data mining.
   - **Difficulty:** 1

2. **Which of the following is NOT an application of clustering?**
   - A. Image recognition
   - B. Webpage content grouping
   - C. Supervised classification
   - D. Grouping similar proteins
   - **Correct Answer:** C
   - **CLO:** Understand the basic concepts and techniques of data mining.
   - **Difficulty:** 2

3. **Which method is described as a set of nested clusters organized as a hierarchical tree?**
   - A. Partitioning Methods
   - B. Density-based Methods
   - C. Grid-based Methods
   - D. Hierarchical Methods
   - **Correct Answer:** D
   - **CLO:** Understand the basic concepts and techniques of data mining.
   - **Difficulty:** 3

4. **What is the main difference between K-means and K-medoids algorithms?**
   - A. K-means uses centroids while K-medoids uses medoids
   - B. K-means is hierarchical while K-medoids is partitioning
   - C. K-means is density-based while K-medoids is grid-based
   - D. K-means handles outliers better than K-medoids
   - **Correct Answer:** A
   - **CLO:** Understand the basic concepts and techniques of data mining.
   - **Difficulty:** 1

5. **Which of the following is a requirement for cluster analysis?**
   - A. Ability to deal with noisy data
   - B. Supervised classification
   - C. Simple segmentation
   - D. Graph partitioning
   - **Correct Answer:** A
   - **CLO:** Understand the basic concepts and techniques of data mining.
   - **Difficulty:** 2

6. **What is the most common measure used to evaluate K-means clusters?**
   - A. Mean Squared Error (MSE)
   - B. Sum of Squared Error (SSE)
   - C. Root Mean Squared Error (RMSE)
   - D. Mean Absolute Error (MAE)
   - **Correct Answer:** B
   - **CLO:** Evaluate and assess the effectiveness of different data mining techniques.
   - **Difficulty:** 3"""
        )
        completion = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": prompt},
            ],
            max_tokens=max_tokens,
            temperature=temperature,
        )
        return completion.choices[0].message.content

    chapters = "chapters.json"

    with open(chapters, "r") as file:
        data = json.load(file)

    # Find the maximum ID currently in the JSON file
    max_id = max([chapter["id"] for chapter in data["chapters"]], default=0)

    # Generate new ID
    new_id = max_id + 1

    # Main function
    def main(output_json_path):
        mcqs_text = generate_mcqs(text)
        questions = output_handler.parse_mcqs(mcqs_text, new_id)
        output_handler.save_as_json(questions, output_json_path)
        return questions

    main(output_json_path)
