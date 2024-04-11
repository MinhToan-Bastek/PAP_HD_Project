import 'package:flutter/material.dart';

class SearchListReExam extends StatefulWidget {
  final Function(String) onSearch;

  const SearchListReExam({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchListReExamState createState() => _SearchListReExamState();
}

class _SearchListReExamState extends State<SearchListReExam> {
  final TextEditingController _controller = TextEditingController();
  
  @override
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller, // Thêm controller vào TextField
            decoration: InputDecoration(
              hintText: 'Tìm Kiếm',
              hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                    top: 12.0), // Adjust the padding to move the icon down
                child: IconButton( // Thay Icon thành IconButton
                  icon: Icon(Icons.search),
                  onPressed: () {
                    widget.onSearch(_controller.text);
                  },
                ),
              ),
              contentPadding: EdgeInsets.only(top: 30),
            ),
            onSubmitted: widget.onSearch, // Thay hành động từ print sang hàm đã được truyền từ ngoài vào
            onChanged: widget.onSearch, // Thêm onChanged để cập nhật controller
          ),
        ),
      ],
    ),
  );
}

}

