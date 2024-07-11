import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maqderah/Pages/lessons_page.dart';
import 'package:maqderah/models/questionsmodel.dart';

class TestPage extends StatefulWidget {
  final int specificId;

  const TestPage({Key? key, required this.specificId}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  List<String> correctCLOs = [];
  List<String> incorrectCLOs = [];
  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = json.decode(response);

    setState(() {
      var quiz = (data['quizes'] as List).firstWhere(
        (quiz) => quiz['id'] == widget.specificId,
        orElse: () => null,
      );

      if (quiz != null) {
        questions = (quiz['questions'] as List)
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
      }
    });
  }

  void _answerQuestion(int selectedIndex) {
    setState(() {
      bool isCorrectAnswer = questions[currentQuestionIndex].correctAnswer ==
          questions[currentQuestionIndex].answers.keys.toList()[selectedIndex];

      if (isCorrectAnswer) {
        correctAnswers++;
        correctCLOs.add(questions[currentQuestionIndex].clo);
        totalScore += questions[currentQuestionIndex].difficulty;
      } else {
        incorrectCLOs.add(questions[currentQuestionIndex].clo);
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    String mostMissedCLO = incorrectCLOs.isNotEmpty
        ? incorrectCLOs.reduce((a, b) =>
            incorrectCLOs.where((v) => v == a).length >
                    incorrectCLOs.where((v) => v == b).length
                ? a
                : b)
        : 'None';

    String mostCorrectCLO = correctCLOs.isNotEmpty
        ? correctCLOs.reduce((a, b) => correctCLOs.where((v) => v == a).length >
                correctCLOs.where((v) => v == b).length
            ? a
            : b)
        : 'None';

    int totalQuestions = questions.length;
    double percentage = (correctAnswers / totalQuestions) * 100;
    String level = 'Beginner';
    if (percentage > 30 && percentage <= 70) {
      level = 'Intermediate';
    } else if (percentage > 70) {
      level = 'Expert';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Correct Answers: $correctAnswers'),
              Text('Incorrect Answers: ${totalQuestions - correctAnswers}'),
              SizedBox(height: 10),
              Text('Your Strengths:'),
              Text(mostCorrectCLO),
              SizedBox(height: 10),
              Text('Your Weaknesses:'),
              Text(mostMissedCLO),
              SizedBox(height: 10),
              Text('Total Score: $totalScore'),
              SizedBox(height: 10),
              Text('Percentage: ${percentage.toStringAsFixed(2)}%'),
              SizedBox(height: 10),
              Text('Level: $level'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Home Page'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            if (level != 'Expert')
              TextButton(
                child: Text('Lessons Page'),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonsPage(clo: mostMissedCLO),
                      ));
                },
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Color(0xFF2D514B),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Question ${currentQuestionIndex + 1}/${questions.length}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(400, 150),
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF2D514B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        questions[currentQuestionIndex].questionText,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: questions[currentQuestionIndex]
                          .answers
                          .values
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) => Column(
                                children: [
                                  SizedBox(
                                    width: 400,
                                    height: 60,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _answerQuestion(entry.key),
                                      child: Text(entry.value),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(200, 50),
                                        backgroundColor: Colors.white,
                                        foregroundColor: Color(0xFF2D514B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
