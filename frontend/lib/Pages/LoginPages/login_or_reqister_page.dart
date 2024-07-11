import 'package:flutter/material.dart';
import 'package:maqderah/Pages/LoginPages/login_page.dart';
import 'package:maqderah/Pages/LoginPages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // show login page
  bool showLogin = true;

  // change the page
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return RegisterPage(onTap: togglePages);
    } else {
      return LoginPage(onTap: togglePages);
    }
  }
}
