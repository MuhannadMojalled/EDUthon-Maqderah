import 'package:flutter/material.dart';
import 'package:maqderah/Pages/quiz_page.dart';

class ChapterPage extends StatelessWidget {
  final String title;

  ChapterPage({required this.title});

  @override
  Widget build(BuildContext context) {
    int id = 1;
    if (title == 'Introduction to Python') {
      id = 1;
    } else if (title == 'Data Structures and Algorithms') {
      id = 2;
    } else if (title == 'Calculus I') {
      id = 3;
    } else if (title == 'Linear Algebra') {
      id = 4;
    } else if (title == 'Atomic Structure and Periodicity') {
      id = 5;
    } else if (title == 'Chemical Bonding ') {
      id = 6;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF2D514B),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2D514B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Questions: 10',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'Durration: 10 minutes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(400, 30),
                  backgroundColor: const Color(0xFF2D514B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  )),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestPage(
                            specificId: 8,
                          )),
                );
              },
              child: Text(
                'Start Quiz',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
