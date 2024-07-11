import json


def return_users_courses(user_id):
    # Load JSON data from files
    def load_json(file_path):
        with open(file_path, "r") as file:
            return json.load(file)

    # Method to get courses by user ID
    def get_courses_by_user_id(user_id, courses_data):
        user_courses = []
        for course in courses_data["courses"]:
            if user_id in course["user_ids"]:
                user_courses.append(course)
        return user_courses

    # Method to get chapters by course ID
    def get_chapters_by_course_id(course_id, chapters_data):
        course_chapters = []
        for chapter in chapters_data["chapters"]:
            if chapter["id"] == course_id:
                course_chapters.append(chapter)
        return course_chapters

    # Method to get questions by chapter ID
    def get_questions_by_chapter_id(chapter_id, chapters_data):
        chapter_questions = []
        for chapter in chapters_data["chapters"]:
            if chapter["id"] == chapter_id:
                chapter_questions = chapter["questions"]
                break
        return chapter_questions

    # Load data
    courses_data = load_json("courses.json")
    chapters_data = load_json("chapters.json")

    # Get courses for the user
    user_courses = get_courses_by_user_id(user_id, courses_data)

    # For each course, get chapters and questions
    output_data = {
        "user_id": user_id,
        "courses": [
            {
                "id": course["course_id"],
                "name": course["name"],
                "chapters": [
                    {
                        "id": chapter["id"],
                        "name": chapter["name"],
                        "summary": chapter["summary"],
                        "questions": chapter["questions"],
                    }
                    for chapter in get_chapters_by_course_id(
                        course["course_id"], chapters_data
                    )
                ],
            }
            for course in user_courses
        ],
    }

    # Save the combined data to a JSON file
    with open(f"user_{user_id}_courses_chapters_questions.json", "w") as outfile:
        json.dump(output_data, outfile, indent=4)

    return f"user_{user_id}_courses_chapters_questions.json"
