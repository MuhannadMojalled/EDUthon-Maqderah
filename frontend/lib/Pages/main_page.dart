import 'package:flutter/material.dart';
import 'package:maqderah/Pages/chat_page.dart';
import 'package:maqderah/Pages/home_page.dart';
import 'package:maqderah/Pages/user_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Track the current tab index
  final List<Widget> _children = [
    HomePage(),
    chatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 74, 97)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Color.fromARGB(255, 0, 74, 97)),
            label: 'Maqderah Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 74, 97)),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 74, 97),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update current tab index
    });
  }
}
