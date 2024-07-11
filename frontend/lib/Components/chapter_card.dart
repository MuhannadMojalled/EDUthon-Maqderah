import 'package:flutter/material.dart';
import 'package:maqderah/Pages/chapter_info_page.dart';

class ChapterCard extends StatelessWidget {
  final String title;
  final String course;

  ChapterCard({required this.title, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChapterPage(title: title),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
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
                      Icon(
                        Icons.play_arrow_rounded,
                        size: 50,
                      )
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
