import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/components/ListPatientDetail/ScrollListTotal.dart';
import 'package:pap_hd/components/ListPatientDetail/SearchListPatient.dart';
import 'package:pap_hd/components/ListPatientDetail/TitlePatientDetail.dart';
import 'package:pap_hd/components/ListPatientDetail/listbodyPatient.dart';
import 'package:pap_hd/model/ListPatient_CardScroll.dart';
import 'package:pap_hd/services/api_service.dart';

class Patient {
  final int id;
  final String maBenhNhan;
  final String tenBenhNhan;
  final String cccd;
  final String soDienThoai;
  final DateTime? ngayDuocDuyet;

  Patient({
    required this.id,
    required this.maBenhNhan,
    required this.tenBenhNhan,
    required this.cccd,
    required this.soDienThoai,
    this.ngayDuocDuyet,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['IdBenhNhan'],
      maBenhNhan: json['MaBenhNhan'],
      tenBenhNhan: json['TenBenhNhan'],
      cccd: json['CCCD'],
      soDienThoai: json['SoDienThoai'],
      ngayDuocDuyet: json['NgayDuocDuyet'] != null
          ? DateTime.parse(json['NgayDuocDuyet'])
          : null,
    );
  }
}

class ListPatientDetail extends StatefulWidget {
  final String username;
  final List<Patient> patientsList;
  final PatientSummary summary;
  final String tenChuongTrinh;

  const ListPatientDetail(
      {Key? key,
      required this.username,
      required this.patientsList,
      required this.summary,
      required this.tenChuongTrinh})
      : super(key: key);

  @override
  _ListPatientDetailState createState() => _ListPatientDetailState();
}

class _ListPatientDetailState extends State<ListPatientDetail> {
  int _currentStatus = -1;
  int _currentPage = 1;
  bool _isFetching = false;
  final List<Patient> _patients = [];
  List<Patient> _filteredPatients = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMorePatients();
    _scrollController.addListener(_onScroll);
    _filteredPatients = _patients;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isFetching &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _fetchMorePatients();
    }
  }

  String convertToFormattedDate(String isoDateString) {
    try {
      DateTime dateTime = DateTime.parse(isoDateString);

      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return isoDateString;
    }
  }

  Future<void> _fetchMorePatients() async {
    if (_isFetching) return;
    setState(() => _isFetching = true);

    // Tạo một instance của ApiService
    ApiService apiService = ApiService();

    try {
      final response = await apiService.fetchPatients(
        username: widget.username,
        status: _currentStatus,
        pageIndex: _currentPage,
        pageSize: 5,
        sortColumn: "IdBenhNhan",
        sortDir: "Asc",
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('ListPatients')) {
        List<dynamic> patientsJson = response['ListPatients'];
        List<Patient> newPatients =
            patientsJson.map((json) => Patient.fromJson(json)).toList();

        if (newPatients.isNotEmpty) {
          setState(() {
            _currentPage++;
            _patients.addAll(newPatients);
            // Cập nhật _filteredPatients mỗi khi có dữ liệu mới
            _filteredPatients = _patients;
          });
        }
      }
    } catch (e) {
      print("Error fetching more patients: $e");
    } finally {
      setState(() => _isFetching = false);
    }
  }

  void filterPatients(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        // Trả về trạng thái ban đầu nếu không có tìm kiếm
        _filteredPatients = _patients;
      });
      return;
    }
    // Gọi API với tham số tìm kiếm
    try {
      final response = await ApiService().fetchPatients(
        username: widget.username,
        query: searchText,
        status: -1,
        pageIndex: 1,
        pageSize: 5,
        sortColumn: "IdBenhNhan",
        sortDir: "Asc",
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('ListPatients')) {
        List<dynamic> patientsJson = response['ListPatients'];
        List<Patient> newPatients =
            patientsJson.map((json) => Patient.fromJson(json)).toList();

        setState(() {
          _filteredPatients = newPatients;
        });
      }
    } catch (e) {
      print("Error searching patients: $e");
      setState(() {
        _filteredPatients = [];
      });
    }
  }

  void fetchPatientsByStatus(int status) async {
 
  if (_currentStatus != status) {
    _currentPage = 1;  
    _patients.clear(); 
  _currentStatus = status;

  // Làm mới danh sách
  setState(() {
    _isFetching = true;
    _filteredPatients = []; 
  });

  try {
    final response = await ApiService().fetchPatients(
      username: widget.username,
      status: status,
      pageIndex: _currentPage,
      pageSize: 5,
      sortColumn: "IdBenhNhan",
      sortDir: "Asc",
    );

    if (response is Map<String, dynamic> && response.containsKey('ListPatients')) {
      List<dynamic> patientsJson = response['ListPatients'];
      List<Patient> newPatients = patientsJson.map((json) => Patient.fromJson(json)).toList();

      setState(() {
        _filteredPatients.addAll(newPatients);
        _patients.addAll(newPatients);  
        if (newPatients.isNotEmpty) {
          _currentPage++; 
        }
        _isFetching = false; 
      });
    }
  } catch (e) {
    print("Error fetching patients by status: $e");
    setState(() {
      _isFetching = false; 
    });
  }
}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/homeScreen/home_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              TitlePatientDetail(
                tenChuongTrinh: widget.tenChuongTrinh,
              ),
              ScrollPatient(
                summary: widget.summary,
                onTap: fetchPatientsByStatus,
              ),
              SearchListPatients(
                onSearch: filterPatients,
              ),
              Expanded(
                child: _filteredPatients.isEmpty && !_isFetching
                    ? Center(
                        child: Text(
                          'Không có dữ liệu !',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            _filteredPatients.length + (_isFetching ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < _filteredPatients.length) {
                            final patient = _filteredPatients[index];
                            return CustomListPatient(
                              personName:
                                  '${patient.maBenhNhan} - ${patient.tenBenhNhan}',
                              card: patient.cccd,
                              telephone: patient.soDienThoai,
                              joinDate: convertToFormattedDate(
                                  patient.ngayDuocDuyet?.toIso8601String() ??
                                      'Chưa duyệt'),
                              status: _currentStatus,
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
