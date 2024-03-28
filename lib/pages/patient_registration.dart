import 'package:flutter/material.dart';
import 'package:pap_hd/components/bottomNavBar/regist_bottomNavBar.dart';
import 'package:pap_hd/components/patient_registration/attached_document.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:pap_hd/components/patient_registration/title_patientRegis.dart';

class PatientRegistScreen extends StatefulWidget {
  @override
  State<PatientRegistScreen> createState() => _PatientRegistScreenState();
}

class _PatientRegistScreenState extends State<PatientRegistScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            // Ảnh nền cho toàn bộ màn hình
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homeScreen/home_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              TitlePatientRegist(), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        //SizedBox(height: 5),
                        PatientInfoForm(),
                        AttachmentSection(),

                        AttachedDocumentsSection(),
                         AttachmentSection(
 
),
                        // Thêm các widget khác nếu cần
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
     bottomNavigationBar: CustomBottomNavBarRegist(
      ),

    );
  }
}
