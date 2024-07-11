class Question {
  final String questionText;
  final Map<String, String> answers;
  final String correctAnswer;
  final String clo;
  final int difficulty;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswer,
    required this.clo,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['question']['question'],
      answers: Map<String, String>.from(json['answers']),
      correctAnswer: json['correct_answer'],
      clo: json['clo'],
      difficulty:
          int.parse(json['difficulty'].toString().replaceAll("** ", "")),
    );
  }
}
