import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/pages/details.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';

class Hospital {
  final String maBenhVien;
  final String tenBenhVien;

  Hospital({required this.maBenhVien, required this.tenBenhVien});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      maBenhVien: json['MaBenhVien'],
      tenBenhVien: json['TenBenhVien'],
    );
  }
}





class PatientInfoForm extends StatefulWidget {
  final String pid;
  final String maChuongTrinh;
  final String username;

  PatientInfoForm(
      {Key? key,
      required this.maChuongTrinh,
      required this.username,
      required this.pid})
      : super(key: key);
  @override
  PatientInfoFormState createState() => PatientInfoFormState();
}

class PatientInfoFormState extends State<PatientInfoForm> {
    String searchQuery = '';
  List<Hospital> filteredHospitals = [];
  
  bool _isHospitalValid = false;
  bool _isNameValid = false;
  bool _isCccdValid = false;
  bool _isPhoneValid = false;
  bool _isJoiningDateValid = false;
  bool _isFormValid = true;
  @override
  void initState() {
    super.initState();
    print('Username ở màn hình đăng ký bệnh nhân: ${widget.username}');
    _fetchHospitalData();
    
  }

  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  // Thay đổi biến này để lưu trữ danh sách bệnh viện nhận được từ API
  List<Hospital> hospitalList = [];
// Để lưu trữ MaBenhVien của bệnh viện được chọn
  String? selectedMaBenhVien;

  
void showSearchHospitalModal(BuildContext context, List<Hospital> hospitals, void Function(String?) onSelect) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      String query = '';
      List<Hospital> filteredHospitals = hospitals;

      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Tìm kiếm bệnh viện',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    query = value.toLowerCase();
                    setState(() {
                      filteredHospitals = hospitals
                          .where((hospital) => hospital.tenBenhVien.toLowerCase().contains(query))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredHospitals.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredHospitals[index].tenBenhVien),
                      onTap: () {
                        onSelect(filteredHospitals[index].maBenhVien);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

  void resetFormData() {
    // Reset các TextEditingController
    _joiningDateController.clear();
    _appointmentDateController.clear();
    _nameController.clear();
    _cccdController.clear();
    _phoneController.clear();

    // Reset trạng thái của checkboxes và radio buttons
    // Ví dụ: isChecked = false;

    // Nếu sử dụng Provider để quản lý dữ liệu, gọi hàm reset tương ứng
    Provider.of<DocumentsData>(context, listen: false);
    Provider.of<DocumentImagesProvider>(context, listen: false).reset();
  }

  // void _fetchHospitalData() async {
  //   try {
  //     final List<Hospital> hospitals = await ApiService().fetchHospitals(
  //         widget.username); // Thay thế hàm và URL API thực tế của bạn
  //     setState(() {
  //       hospitalList = hospitals;
  //     });
  //   } catch (e) {
  //     print('Lỗi khi lấy dữ liệu bệnh viện: $e');
  //   }
  // }
  void _fetchHospitalData() async {
    try {
      final List<Hospital> hospitals = await ApiService().fetchHospitals(widget.username);
      setState(() {
        hospitalList = hospitals;
        filteredHospitals = List.from(hospitals); // Cập nhật danh sách đã lọc
      });
    } catch (e) {
      print('Lỗi khi lấy dữ liệu bệnh viện: $e');
    }
  }

  @override
  void dispose() {
    _joiningDateController.dispose();
    _appointmentDateController.dispose();
    _nameController.dispose();
    _cccdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = _dateFormat.format(pickedDate);
      });
    }
  }

  void submitPatientInfo() async {
    // Kiểm tra xem các trường đã được nhập hay chưa
    _isNameValid = _nameController.text.isNotEmpty;
    _isCccdValid = _cccdController.text.isNotEmpty;
    _isPhoneValid = _phoneController.text.isNotEmpty;
    _isJoiningDateValid = _joiningDateController.text.isNotEmpty;

    _isFormValid =
        _isNameValid && _isCccdValid && _isPhoneValid && _isJoiningDateValid;

    if (!_isFormValid) {
      setState(() {}); // Cập nhật UI để hiển thị thông báo lỗi
      return;
    }

    final documentsData = Provider.of<DocumentsData>(context, listen: false);
    final documentImagesProvider =
        Provider.of<DocumentImagesProvider>(context, listen: false);
    List<XFile?> documentImages = documentImagesProvider.documentImages;
    final Map<String, dynamic> patientData = {
      "MaChuongTrinh": widget.maChuongTrinh,
      "MaBenhVien": selectedMaBenhVien,
      "TenBenhNhan": _nameController.text.trim(),
      "CCCD": _cccdController.text.trim(),
      "SoDienThoai": _phoneController.text.trim(),
      "NgayThamGia": _joiningDateController.text.trim(),
      "NgayHenTaiKham": _appointmentDateController.text.trim(),
      "Check_M1": documentsData.checkedItems['M1']! ? "1" : "0",
      "Check_M2": documentsData.checkedItems['M2']! ? "1" : "0",
      "Check_CCCD": documentsData.checkedItems['CCCD']! ? "1" : "0",
      "Check_HoSoBenhAn":
          documentsData.checkedItems['Hồ sơ bệnh án']! ? "1" : "0",
      "Check_ContactLog":
          documentsData.checkedItems['Contact log']! ? "1" : "0",
      "Check_ADR": documentsData.selectedADR == 0 ? "1" : "0",
      "Username": widget.username,
    };
    for (var image in documentImages.where((element) => element != null)) {
      print(
          "Hình ảnh: ${image!.path}, Kích thước: ${await image.length()} bytes");
      // Bạn cũng có thể hiển thị thông tin này trên UI nếu muốn
    }

    try {
      await ApiService().postPatientData(patientData, documentImages);
      Provider.of<DocumentsData>(context, listen: false).reset();
      Provider.of<DocumentImagesProvider>(context, listen: false).reset();
      // Hiển thị thông báo thành công hoặc điều hướng
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DetailScreen(pid: widget.pid, username: widget.username)),
      );
    } catch (e) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi gửi thông tin: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchableDropdown("Bệnh viện", context, hospitalList, true),
          //_buildDropDown('Bệnh viện', hospitalList, true),
          if (!_isFormValid && !_isHospitalValid)
            Text(
              'Vui lòng chọn Bệnh viện',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: 5,
          ),
          _buildTextField('Họ & tên', _nameController, true),
          if (!_isFormValid && !_isNameValid)
            Text(
              'Vui lòng nhập Họ & Tên',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 5),
          _buildTextField('CCCD', _cccdController, true),
          if (!_isFormValid && !_isCccdValid)
            Text(
              'Vui lòng nhập CCCD',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 5),
          _buildTextField('Số điện thoại', _phoneController, true),
          if (!_isFormValid && !_isPhoneValid)
            Text(
              'Vui lòng nhập Số điện thoại',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 5),
          _buildDateField('Ngày tham gia', _joiningDateController, true),
          if (!_isFormValid && !_isJoiningDateValid)
            Text(
              'Vui lòng chọn Ngày tham gia',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: 5,
          ),
          _buildDateField(
              'Ngày hẹn tái khám', _appointmentDateController, false),
          //Nút gửi thông tin
          // ElevatedButton(
          //   onPressed: submitPatientInfo,
          //   child: Text('Gửi thông tin'),
          // ),
        ],
      ),
    );
  }

  Widget _buildDropDown(String label, List<Hospital> items, bool isRequired) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedMaBenhVien,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.teal, fontSize: 16),
            children: isRequired
                ? [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ]
                : [],
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
      ),
      items: items.map((Hospital hospital) {
        return DropdownMenuItem<String>(
          value: hospital.maBenhVien,
          child: Text(
            hospital.tenBenhVien,
            style: TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedMaBenhVien = newValue;
        });
      },
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isRequired) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.teal, fontSize: 16),
            children: isRequired
                ? [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ]
                : [],
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
        // Chỉnh sửa content padding tại đây
      ),
    );
  }

//   Widget _buildSearchableDropdown(BuildContext context, List<Hospital> items) {
//   return TextFormField(
//     readOnly: true,
//     controller: TextEditingController(text: items.firstWhere((item) => item.maBenhVien == selectedMaBenhVien, orElse: () => Hospital(maBenhVien: '', tenBenhVien: '')).tenBenhVien),
//     decoration: InputDecoration(
//       labelText: 'Bệnh viện',
//       suffixIcon: Icon(Icons.arrow_drop_down),
//     ),
//     onTap: () => showSearchHospitalModal(context, items, (selectedValue) {
//       setState(() {
//         selectedMaBenhVien = selectedValue;
//       });
//     }),
//   );
// }
Widget _buildSearchableDropdown(String label, BuildContext context, List<Hospital> items, bool isRequired) {
  return TextFormField(
    readOnly: true,
    controller: TextEditingController(text: items.firstWhere((item) => item.maBenhVien == selectedMaBenhVien, orElse: () => Hospital(maBenhVien: '', tenBenhVien: '')).tenBenhVien),
    decoration: InputDecoration(
      label: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(color: Colors.teal, fontSize: 16),
          children: isRequired
              ? [
                  TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red, fontSize: 16))
                ]
              : [],
        ),
      ),
      enabledBorder: _enabledBorder(),
      focusedBorder: _focusedBorder(),
      contentPadding: EdgeInsets.only(top: 15),
      suffixIcon: Icon(Icons.arrow_drop_down),
    ),
    onTap: () => showSearchHospitalModal(context, items, (selectedValue) {
      setState(() {
        selectedMaBenhVien = selectedValue;
      });
    }),
  );
}




  Widget _buildDateField(
    String label,
    TextEditingController controller,
    bool isRequired,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.teal, fontSize: 16),
            children: isRequired
                ? [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ]
                : [],
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
              top: 10.0), // Thêm một khoảng trống phía trên icon
          child: IconButton(
            icon: Icon(Icons.calendar_month, color: Colors.teal),
            onPressed: () {
              _selectDate(context, controller);
            },
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
      ),
      onTap: () {
        _selectDate(context, controller);
      },
    );
  }

  UnderlineInputBorder _enabledBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
    );
  }

  UnderlineInputBorder _focusedBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal, width: 2),
    );
  }
}
