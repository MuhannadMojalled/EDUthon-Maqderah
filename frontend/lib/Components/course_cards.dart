import 'package:flutter/material.dart';
import 'package:maqderah/Pages/courses_page.dart';

class CourseCard extends StatelessWidget {
  final String title;

  CourseCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePage(
              title: title,
            ),
          ),
        );
      },
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(60.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: const Color.fromARGB(255, 0, 74, 97),
                          fontSize: 20.0),
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        "2 contents ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 74, 97),
                            fontSize: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
