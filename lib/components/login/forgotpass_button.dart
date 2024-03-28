import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ForgotPasswordButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, // Gán hành động khi nút được nhấn
      child: Text('Forgot password?', style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal),),
    );
  }
}