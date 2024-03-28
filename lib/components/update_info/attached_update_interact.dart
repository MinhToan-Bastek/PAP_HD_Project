import 'package:flutter/material.dart';

class AttachedUpdateInteract extends StatefulWidget {
  const AttachedUpdateInteract({super.key});

  @override
  State<AttachedUpdateInteract> createState() => _AttachedUpdateInteractState();
}

class _AttachedUpdateInteractState extends State<AttachedUpdateInteract> {
   int? selectedInteract;
   @override
  void initState() {
    super.initState();
    selectedInteract = 0;
  }
  @override
  Widget build(BuildContext context) {
     selectedInteract ??= 0;
    return Container(
       padding: EdgeInsets.all(16),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tương tác bệnh nhân',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildRadioTile('Có', 0),
              ),
              Expanded(
                child: _buildRadioTile('Không', 1),
              ),
            ],
          ),
        ]
       )
      
    );
  }

  Widget _buildRadioTile(String title, int value) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.teal,
      ),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: selectedInteract,
            onChanged: (int? newValue) {
              setState(() {
                selectedInteract = newValue;
              });
            },
            activeColor: Colors.teal,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16), // Sử dụng fontSize cho chữ
          ),
        ],
      ),
    );
  }
}