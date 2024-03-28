import 'package:flutter/material.dart';
import 'package:pap_hd/components/bottomNavBar/pending_bottomNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/regist_bottomNavBar.dart';
import 'package:pap_hd/components/patient_registration/attached_document.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:pap_hd/components/patient_registration/title_patientRegis.dart';
import 'package:pap_hd/components/patient_search/info_patientSearch.dart';
import 'package:pap_hd/components/patient_search/searchBar.dart';
import 'package:pap_hd/components/patient_search/title_patientSearch.dart';

class PatientSearchScreen extends StatefulWidget {
  
  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
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
              TitlePatientSearch(), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        //SizedBox(height: 5),
                        SearchBarWidget(),
                        PatientInfoSearch(),
                        AttachmentSection(
  
),
                        //AttachedDocumentsSection(),
                         //AttachmentSection(),
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
      bottomNavigationBar: CustomBottomNavBarPending(),
    );
  }
}
