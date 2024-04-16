import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/pages/info_ReExam_Pending.dart';
import 'package:pap_hd/model/img_provider.dart';
import 'package:pap_hd/pages/patient_registration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBarRegist extends StatelessWidget {
  
   final VoidCallback onSavePressed;
   final GlobalKey<PatientInfoFormState> formKey;
  final picker = ImagePicker();
  String? base64String;
  CustomBottomNavBarRegist({super.key,required this.onSavePressed,required this.formKey});

  
  Future<void> getImageFromCamera(BuildContext context) async {
    // Yêu cầu quyền truy cập camera
    var permissionStatus = await Permission.camera.request();

    if (permissionStatus == PermissionStatus.granted) {
       final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        // Xử lý khi có ảnh được chọn từ camera
         Provider.of<ImageProviderModel>(context, listen: false).addImage(pickedFile.path);
        File imageFile = File(pickedFile.path);
         List<int> imageBytes = File(pickedFile!.path).readAsBytesSync();
    base64String = base64Encode(imageBytes);
    debugPrint(base64String);
        // Do something with the image file
      
      } else {
        print('Không có ảnh được chọn.');
      }
    } else {
      // Xử lý khi người dùng từ chối quyền
      print('Quyền truy cập camera không được cấp.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quyền truy cập camera không được cấp.'),
        ),
      );
    }
  }

 Future<void> getImageFromGallery(BuildContext context) async {
  var permissionStatus = await Permission.photos.request();

  if (permissionStatus == PermissionStatus.granted) {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Sử dụng Provider để thêm ảnh vào danh sách
      Provider.of<ImageProviderModel>(context, listen: false).addImage(pickedFile.path);
    List<int> imageBytes = File(pickedFile!.path).readAsBytesSync();
    base64String = base64Encode(imageBytes);
    debugPrint(base64String);
    } else {
      print('Không có ảnh được chọn.');
    }
  } else {
    print('Quyền truy cập thư viện ảnh không được cấp.');
  }
}


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_home.svg',
            height: 30,
          ),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_scan.svg',
            height: 30,
          ),
          label: 'Chụp tài liệu',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_image.svg',
            height: 30,
          ),
          label: 'Chọn từ thư viện',
        ),
        BottomNavigationBarItem(
          
          icon: SvgPicture.asset(
            'assets/bottomNavBar/icon_save.svg',
            height: 30,
          ),
          label: 'Lưu bệnh nhân',        
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(fontSize: 8),
      unselectedLabelStyle: TextStyle(fontSize: 8),
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            //  Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
            // break;
          case 1:
            getImageFromCamera(context);
            break;
          case 2:
            getImageFromGallery(context);
            break;
          case 3:
         onSavePressed();
            break;
        }
      },
    );
  }
}
