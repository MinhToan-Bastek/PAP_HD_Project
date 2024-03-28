import 'package:flutter/material.dart';
import 'package:pap_hd/pages/patient_search.dart';
import 'package:pap_hd/pages/patient_searchApproved.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Text('Tìm bệnh nhân'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
       extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/homeScreen/home_background.png"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('Nhập mã, tên, CCCD để tìm kiếm bệnh nhân.'),
        ),
      ),
    );
  }
}

// Tạo một SearchDelegate để xử lý hành vi tìm kiếm
class CustomSearchDelegate extends SearchDelegate {
   CustomSearchDelegate() : super(
    searchFieldLabel: "Tìm theo mã, tên, CCCD", // Đặt placeholder cho search bar
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          close(context, null);
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,color: Colors.black,),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.toLowerCase() == 'bệnh nhân 1') {
      // Điều hướng đến PatientSearchScreen nếu người dùng tìm "bệnh nhân 1"
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientSearchScreen()));

      });
    }
    else if(query.toLowerCase() == 'bệnh nhân 2'){
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PatientSearchApprovedScreen()));
      });
    }
    return Center(
      child: Text('Không tìm thấy dữ liệu: "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = ['Bệnh nhân 1', 'Bệnh nhân 2', 'Bệnh nhân 3'];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

