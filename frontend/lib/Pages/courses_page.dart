import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maqderah/Components/chapter_card.dart';

class CoursePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final String title;

  CoursePage({required this.title});

  @override
  Widget build(BuildContext context) {
    String? displayName = user?.displayName;
    String ch1 = "";
    String ch2 = "";
    if (title == 'Python Programming (CS101)') {
      ch1 = 'Introduction to Python';
      ch2 = 'Data Structures and Algorithms';
    } else if (title == 'Mathematics (MATH101)') {
      ch1 = 'Calculus I';
      ch2 = 'Linear Algebra';
    } else if (title == 'Chemistry (CHEM101)') {
      ch1 = 'Atomic Structure and Periodicity';
      ch2 = 'Chemical Bonding ';
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 310,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2D514B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Image.asset("assets/logo2.png"),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20.0),
                        Text(
                          'Welcome ${displayName ?? 'User'}', // Default to 'User' if displayName is null
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 200,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_circle_left,
                                color: Colors.white))
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20.0),
                        Text(
                          'Maqderah is here to help you learn and grow.',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 18,
                        borderRadius: BorderRadius.circular(60.0),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              color: const Color.fromARGB(255, 35, 67, 154),
                            ),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 35, 67, 154),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Chapters',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 74, 97),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ChapterCard(
                  title: ch1,
                  course: title,
                ),
                const SizedBox(height: 10.0),
                ChapterCard(
                  title: ch2,
                  course: title,
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
