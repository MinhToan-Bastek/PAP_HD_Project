import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SignUpButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: onPressed,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xFF0AB678),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
