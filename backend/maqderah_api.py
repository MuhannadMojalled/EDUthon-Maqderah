import json
import os
from flask import Flask, request, jsonify, send_file
from audio_handle import audio_handler
import generate_questions
import audio_advice
from get_advice import generate_advice, get_videos
from tpoics_generate import generateQuestionsTopic
import userCourses
from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

UPLOAD_FOLDER = "uploads"


@app.route("/greet", methods=["GET"])
def greet():
    return jsonify({"message": "Hello, World!"})


@app.route("/upload", methods=["POST"])
def upload_file():
    if "file" not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files["file"]

    if file.filename == "":
        return jsonify({"error": "No selected file"}), 400

    if file and file.filename.endswith(".pdf"):
        # Ensure the uploads directory exists
        if not os.path.exists(UPLOAD_FOLDER):
            os.makedirs(UPLOAD_FOLDER)

        global file_path
        file_path = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(file_path)
        return jsonify({"message": "File successfully uploaded"}), 200

    return jsonify({"error": "Invalid file format. Only PDFs are allowed"}), 400


@app.route("/generate-questions", methods=["POST"])
def getquestions():
    if not file_path:
        return jsonify({"error": "No file uploaded"}), 400

    # Generate questions
    generate_questions.generateQuestions(file_path)

    return jsonify({"message": "Questions generated successfully"}), 200


@app.route("/generate-audio-advice", methods=["POST"])
def getAudioAdvice():
    data = request.get_json()
    if not data or "clo" not in data:
        return jsonify({"error": "No CLO data provided"}), 400

    clo = data["clo"]

    try:
        # Generate the audio advice
        audio_advice.generate_audio(clo)

        audio_file_path = "advice.mp3"

        # Send the audio file
        return send_file(
            audio_file_path,
            mimetype="audio/mp3",
            as_attachment=True,
            download_name="advice.mp3",
        )

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Route to handle user input and display courses
@app.route("/courses/<int:user_id>", methods=["GET"])
def get_courses(user_id):
    path = userCourses.return_users_courses(user_id)
    with open(path, "r") as file:
        data = json.load(file)
    return jsonify(data)


@app.route("/get-advice", methods=["GET"])
def get_advice():
    clo = request.args.get("clo")
    print(f"Received clo: {clo}")  # Debugging statement
    if clo:
        clo.replace("%20", "")
        advice = generate_advice(clo)
        videos = get_videos(clo)
        response = {"advice": advice, "videos": videos}
    else:
        response = {"error": "No CLO provided"}
    return jsonify(response)


@app.route("/gen", methods=["POST"])
def gettopics():
    topic = request.args.get("topic")
    if not topic:
        return jsonify({"error": "No file uploaded"}), 400

    # Generate questions
    topics = generateQuestionsTopic(topic)

    return jsonify({"topics": topics})


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
