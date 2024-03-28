import 'package:flutter/material.dart';

class RememberCheckBox extends StatefulWidget {
  @override
  _RememberCheckBoxState createState() => _RememberCheckBoxState();
}

class _RememberCheckBoxState extends State<RememberCheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
        ),
        Text('Remember me'),
      ],
    );
  }
}


