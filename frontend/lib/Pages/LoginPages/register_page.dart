import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maqderah/Components/my_button.dart';
import 'package:maqderah/Pages/LoginPages/login_page.dart';
import 'package:maqderah/generated/l10n.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Editing Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign User Up method
  void signUserUp() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      errorMgs('Passwords do not match');
      return;
    }

    // Try sign up
    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Update the user display name
      await userCredential.user?.updateDisplayName(nameController.text.trim());

      // Pop the loading circle
      Navigator.pop(context);

      // Navigate back to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage(onTap: null)),
      );
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle
      Navigator.pop(context);
      // Error message
      errorMgs(e.code);
    }
  }

  // Error Message
  void errorMgs(String error) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 206, 193, 193),
          title: Text(error),
          actions: [
            MyButton(
              onTap: () => Navigator.pop(context),
              text: S.of(context).Ok,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: const Color(0xFF2D514B),
        ),
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
            // Registration form
            Container(
              height: 550,
              width: 350,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(color: Color(0xFF2D514B)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF75A2B2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF75A2B2)),
                        ),
                        prefixIcon: Icon(Icons.person_2_outlined,
                            color: Color(0xFF75A2B2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      const SizedBox(
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
                      controller: emailController,
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Confirm Password",
                        style: TextStyle(color: Color(0xFF2D514B)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: confirmPasswordController,
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
                  const SizedBox(height: 25),
                  MyButton(
                    onTap: signUserUp,
                    text: "Register",
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "AlreadyMember? ",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login Now",
                          style: const TextStyle(
                            color: Color(0xff4D8782),
                            fontWeight: FontWeight.bold,
                          ),
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
