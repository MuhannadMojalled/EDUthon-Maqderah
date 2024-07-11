import json


def parse_mcqs(mcqs_text, new_id):
    questions = []
    mcqs_list = mcqs_text.split("### Questions")[1].strip().split("\n\n")
    for mcq in mcqs_list:
        if mcq.strip():
            parts = mcq.split("\n")
            question = parts[0].strip().replace("**", "")
            options = [
                parts[1].strip().replace("**", ""),
                parts[2].strip().replace("**", ""),
                parts[3].strip().replace("**", ""),
                parts[4].strip().replace("**", ""),
            ]
            correct_answer = (
                parts[5].split(":")[1].strip().replace("**", "").replace(" ", "")
            )
            clo = parts[6].split(":")[1].strip().replace("**", "")
            difficulty = (
                parts[7].split(":")[1].strip().replace("**", "").replace(" ", "")
            )
            questions.append(
                {
                    "question": question,
                    "options": options,
                    "correct_answer": correct_answer,
                    "clo": clo,
                    "difficulty": difficulty,
                }
            )
    return {"id": new_id, "questions": questions}


def save_as_json(questions, output_path):
    formatted_questions = []
    for idx, question_data in enumerate(questions["questions"], start=1):
        question = question_data["question"]
        options = question_data["options"]
        correct_answer = question_data["correct_answer"]
        difficulty = question_data["difficulty"]
        clo = question_data["clo"]

        # Map options to A, B, C, D
        answers = {"A": options[0], "B": options[1], "C": options[2], "D": options[3]}

        # Create the formatted question structure
        formatted_question = {
            "question": {"questionNumber": str(idx), "question": question},
            "answers": answers,
            "correct_answer": correct_answer,
            "clo": clo,
            "difficulty": difficulty,
        }

        formatted_questions.append(formatted_question)
    formatted_data = {
        "id": questions["id"],
        "questions": formatted_questions,
    }

    all_questions = "chapters.json"
    with open(all_questions, "r") as file:
        data = json.load(file)
    # Append the new question to the existing list of questions
    data["chapters"].append(formatted_data)

    # Write updated data back to the JSON file
    with open(all_questions, "w") as file:
        json.dump(data, file, indent=4)
