import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;
  MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF75A2B2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF75A2B2)),
          ),
          prefixIcon: Icon(Icons.email, color: Color(0xFF75A2B2)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
