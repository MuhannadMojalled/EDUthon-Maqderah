import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(
          horizontal: 55,
        ),
        decoration: BoxDecoration(
            color: const Color(0xFF2D514B),
            borderRadius: BorderRadius.circular(35)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
