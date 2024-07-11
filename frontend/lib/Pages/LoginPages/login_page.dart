import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maqderah/Components/my_button.dart';
import 'package:maqderah/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Editing Controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // Sign User In method
  void signUserIn() async {
    // show loding circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      // pop the ldoing circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the ldoing circle
      Navigator.pop(context);
      // Error Msg
      errorMgs(e.code);
    }
  }

  // Wrong Email Message
  void errorMgs(String error) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 206, 193, 193),
            title: Text(error),
            actions: [
              MyButton(
                  onTap: () => Navigator.pop(context), text: S.of(context).Ok),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Color(0xFF2D514B),
        backgroundColor: const Color(0xFF2D514B),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
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
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset("assets/icon.png"),
                  Text(
                    "!لأن التعليم يبدأ من أي مكان",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Destined: Because education starts anywhere",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Username
            Container(
              height: 450,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  const Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(color: Color(0xFF2D514B)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: usernameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF75A2B2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF75A2B2)),
                        ),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Color(0xFF75A2B2)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(color: Color(0xFF2D514B)),
                      ),
                    ],
                  ),
                  // Password
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF75A2B2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF75A2B2)),
                        ),
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Color(0xFF75A2B2)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Forgot Password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).ForgotPassword,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Sign In Button
                  MyButton(
                    text: "Login",
                    onTap: signUserIn,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).NotMember,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          " Register Now",
                          style: const TextStyle(
                              color: Color(0xff4D8782),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
