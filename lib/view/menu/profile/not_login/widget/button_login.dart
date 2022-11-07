import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  ButtonLogin({
    super.key,
    required this.text,
    required this.onPressed,
  });
  String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        fixedSize: MaterialStatePropertyAll<Size>(
          Size(
            double.maxFinite,
            40,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
