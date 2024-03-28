//Version 1
// import 'package:flutter/material.dart';

// class CustomInputField extends StatefulWidget {
//   final String label;
//   final IconData icon;
//   final bool isPassword;
//   final bool isEmail;

//   const CustomInputField({
//     Key? key,
//     required this.label,
//     required this.icon,
//     this.isPassword = false,
//     this.isEmail = false,
//   }) : super(key: key);

//   @override
//   _CustomInputFieldState createState() => _CustomInputFieldState();
// }

// class _CustomInputFieldState extends State<CustomInputField> {
//   bool obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
//       obscureText: widget.isPassword && obscurePassword,
//       decoration: InputDecoration(
//         hintText: widget.label,
//         prefixIcon: Icon(widget.icon, color: Color(0xFF018F65)),
//         suffixIcon: widget.isPassword
//             ? IconButton(
//                 icon: Icon(
//                   obscurePassword
//                       ? Icons.visibility
//                       : Icons.visibility_off,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     obscurePassword = !obscurePassword;
//                   });
//                 },
//               )
//             : null,
//         floatingLabelBehavior: FloatingLabelBehavior.never,
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Color(0xFF03A2B7)),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Color(0xFF03A2B7), width: 2),
//         ),
//         hintStyle: TextStyle(color: Color(0xFF018F65)),
//         // Điều chỉnh kích thước của ô nhập liệu
//         contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 2.0),
//       ),
//     );
//   }
// }

//Version 2

// import 'package:flutter/material.dart';

// class CustomInputField extends StatefulWidget {
//   final String label;
//   final IconData icon;
//   final bool isPassword;
//   final bool isEmail;

//   const CustomInputField({
//     Key? key,
//     required this.label,
//     required this.icon,
//     this.isPassword = false,
//     this.isEmail = false,
//   }) : super(key: key);

//   @override
//   _CustomInputFieldState createState() => _CustomInputFieldState();
// }

// class _CustomInputFieldState extends State<CustomInputField> {
//   bool obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
//       obscureText: widget.isPassword && obscurePassword,
//       decoration: InputDecoration(
//         labelText: widget.label,
//         labelStyle: TextStyle(color: Color(0xFF018F65), fontSize: 18),
       
//         prefixIcon: Transform.translate(
//           offset: Offset(0, 9), // Căn chỉnh vị trí của icon email và password
//           child: Icon(widget.icon, color: Color(0xFF018F65)),
//         ),
       
//         suffixIcon: widget.isPassword
//             ? Transform.translate(
//                 offset: Offset(0, 9), // Căn chỉnh vị trí của icon mắt
//                 child: IconButton(
//                   icon: Icon(
//                     obscurePassword ? Icons.visibility : Icons.visibility_off,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       obscurePassword = !obscurePassword;
//                     });
//                   },
//                 ),
//               )
//             : null,
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Color(0xFF03A2B7)),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Color(0xFF03A2B7), width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Padding cho toàn bộ nội dung nhập liệu
//       ),
//     );
//   }
// }

//Main
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController controller; // Thêm controller

  const CustomInputField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller, // Thêm controller vào constructor
    this.isPassword = false,
    this.isEmail = false,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // Gắn controller vào TextFormField
      keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
      obscureText: widget.isPassword && obscurePassword,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Color(0xFF018F65),
          fontSize: 18,
        ),
        prefixIcon: Icon(widget.icon, color: Color(0xFF018F65)),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFF018F65),
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              )
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF03A2B7)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF03A2B7), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
    );
  }
}



