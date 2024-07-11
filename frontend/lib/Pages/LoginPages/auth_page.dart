import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maqderah/Pages/LoginPages/login_or_reqister_page.dart';
import 'package:maqderah/Pages/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if user is logged in
            if (snapshot.hasData) {
              return MainPage();
            }
            // if user is not logged in
            else {
              return const LoginOrRegisterPage();
            }
          },
        ));
  }
}
