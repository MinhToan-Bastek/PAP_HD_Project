import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pap_hd/pages/patient_search.dart';
import 'package:pap_hd/pages/patient_searchApproved.dart';
import 'package:pap_hd/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  final String username;
  final String pid;
  final String name;
  final String tenChuongTrinh;
  const SearchScreen(
      {super.key,
      required this.username,
      required this.pid,
      required this.name,
      required this.tenChuongTrinh});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showSearch(
        context: context,
        delegate: CustomSearchDelegate(
            widget.username, widget.pid, widget.name, widget.tenChuongTrinh),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm bệnh nhân'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    widget.username, widget.pid, widget.name, widget.tenChuongTrinh),
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
  final String username;
  final String pid;
  final String name;
  final String tenChuongTrinh;
  CustomSearchDelegate(this.username, this.pid, this.name, this.tenChuongTrinh)
      : super(
          searchFieldLabel:
              "Tìm theo mã, tên, CCCD", 
              searchFieldStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
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
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Không có kết quả'),
    );
  }

  void navigateToDetailScreen(BuildContext context, String idBenhNhan) async {
    try {
      final patientDetail = await ApiService().getPatientById(idBenhNhan);
      print('Giá trị TinhTrang: ${patientDetail['TinhTrang']}');
      int tinhTrang = int.parse(patientDetail['TinhTrang']);
      //Trạng thái đang chờ duyệt
      if (tinhTrang == 0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PatientSearchScreen(
                  patientDetail: patientDetail,
                  username: username,
                  id: idBenhNhan,
                  pid: pid,
                  name: name,
                  tenChuongTrinh: tenChuongTrinh,
                )));
      } 
      //Trạng thái đã duyệt
      else if (tinhTrang > 0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PatientSearchApprovedScreen(
                  patientDetail: patientDetail,
                  username: username,
                  tenChuongTrinh: tenChuongTrinh,
                )));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi lấy thông tin bệnh nhân: $e')));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Nhập từ khóa để tìm kiếm'));
    }

    return FutureBuilder(
      future: ApiService().searchPatients(username, query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Không tìm thấy kết quả'));
        } else {
          final List<dynamic> results = snapshot.data ?? [];
          if (results.isEmpty) {
            return Center(child: Text('Không tìm thấy kết quả'));
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final patient = results[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      '${patient['MaBenhNhan']} - ${patient['TenBenhNhan']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CCCD: ${patient['CCCD']}'),
                        Text('Số điện thoại: ${patient['SoDienThoai']}'),
                      ],
                    ),
                    onTap: () => navigateToDetailScreen(
                        context, patient['IdBenhNhan'].toString()),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 0,
                    thickness: 0.2,
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
