import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maqderah/Pages/LoginPages/auth_page.dart'; // Replace with your actual login page import

void signUserOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // Navigate to the login page after logout
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) =>
            AuthPage()), // Replace with your actual login page route
    (route) =>
        false, // This will clear the navigation stack and prevent going back to the profile page
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;
    String? name = user?.displayName;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "USER PAGE",
            style: TextStyle(color: Colors.white, fontFamily: 'SpaceMonoBold'),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  const CircleAvatar(
                    radius: 50,
                    // Replace with your own image asset
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ' ${name ?? 'User Name Not Available'}',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'SpaceMonoBold'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Student',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'SpaceMonoBold'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(
                          ' ${userEmail ?? 'User Email Not Available'}',
                          style: const TextStyle(fontFamily: 'SpaceMonoBold'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () =>
                        signUserOut(context), // Call the logout function
                    child: Text('Logout?'),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
