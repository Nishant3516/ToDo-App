import 'package:flutter/material.dart';

class cusButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  cusButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
