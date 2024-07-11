import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maqderah/Components/course_cards.dart';

class HomePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String? displayName = user?.displayName;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: Color(0xFF2D514B), // Status bar
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
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
                  height: 50,
                ),
                Image.asset("assets/logo2.png"),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20.0),
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
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
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
          ),
          const SizedBox(height: 20.0),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Icon(Icons.class_outlined),
              Text(
                'Courses',
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
                CourseCard(title: 'Python Programming (CS101)'),
                const SizedBox(height: 10.0),
                CourseCard(title: 'Mathematics (MATH101)'),
                const SizedBox(height: 10.0),
                CourseCard(title: 'Chemistry (CHEM101)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}
