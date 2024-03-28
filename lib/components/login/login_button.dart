import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LoginButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('LOGIN',style: TextStyle(color: Colors.white, fontSize: 20),),
      
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0AB678)),
        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
         shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Điều chỉnh độ bo tròn tại đây
          ),
        ),
      ),
    );
  }
}
