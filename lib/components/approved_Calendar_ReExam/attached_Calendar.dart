import 'package:flutter/material.dart';
import 'package:pap_hd/model/checkbox_createADR.dart';
import 'package:provider/provider.dart';

class AttachedCalendar extends StatefulWidget {
  @override
  _AttachedCalendarState createState() =>
      _AttachedCalendarState();
}

class _AttachedCalendarState extends State<AttachedCalendar> {
  @override
  Widget build(BuildContext context) {
    final documentsData = Provider.of<DocumentsDataCreateADR>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 16.0; // Adjust the padding if needed
    double spacing = 2.0; // Adjust the spacing if needed, smaller value will reduce space
    double width = (screenWidth - padding * 2 - spacing) / 2;

    return Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hồ sơ đính kèm bao gồm',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          //SizedBox(height: padding),
          Wrap(
            spacing: spacing, // Adjust the horizontal spacing between checkboxes
            runSpacing: spacing/2, // Adjust the vertical spacing between rows of checkboxes
            children: documentsData.checkedItems.keys.map((key) {
              return Container(
                width: width,
                child: CheckboxListTile(
                  title: Text(key),
                  value: documentsData.checkedItems[key],
                  onChanged: (bool? value) {
                    documentsData.setCheckedItem(key, value!);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4), // Reduce padding if needed
                   activeColor: Colors.teal,
                ),
              );
            }).toList(),
          ),
          
          
        ],
      ),
    );
  }
}
