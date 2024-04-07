import 'package:flutter/material.dart';

class SearchListPatients extends StatefulWidget {
  final Function(String) onSearch;

  const SearchListPatients({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchListPatientsState createState() => _SearchListPatientsState();
}

class _SearchListPatientsState extends State<SearchListPatients> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Tìm kiếm',
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              widget.onSearch('');
            },
          ),
        ),
        onChanged: widget.onSearch,
      ),
    );
  }
}
