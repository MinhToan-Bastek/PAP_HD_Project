import 'package:flutter/material.dart';
import 'package:pap_hd/components/bottomNavBar/approved_bottomNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/pending_bottomNavBar.dart';
import 'package:pap_hd/components/bottomNavBar/regist_bottomNavBar.dart';
import 'package:pap_hd/components/patient_registration/attached_document.dart';
import 'package:pap_hd/components/patient_registration/attachment_section.dart';
import 'package:pap_hd/components/patient_registration/info_patientRegis.dart';
import 'package:pap_hd/components/patient_registration/title_patientRegis.dart';
import 'package:pap_hd/components/patient_search/info_patientSearch.dart';
import 'package:pap_hd/components/patient_search/searchBar.dart';
import 'package:pap_hd/components/patient_search/search_approved/attachmentSection_approSearch.dart';
import 'package:pap_hd/components/patient_search/search_approved/check_radio_ApprovedSearch.dart';
import 'package:pap_hd/components/patient_search/search_approved/searchBarApproved.dart';
import 'package:pap_hd/components/patient_search/search_approved/title_approved.dart';
import 'package:pap_hd/components/patient_search/title_patientSearch.dart';

class PatientSearchApprovedScreen extends StatefulWidget {
   final Map<String, dynamic> patientDetail;
   final String username;
  const PatientSearchApprovedScreen({super.key,required this.patientDetail,required this.username});
  @override
  State<PatientSearchApprovedScreen> createState() => _PatientSearchApprovedScreenState();
}

class _PatientSearchApprovedScreenState extends State<PatientSearchApprovedScreen> {
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
              TitleApprovedSearch(username: widget.username,), // Phần title không cuộn
              Expanded(
                child: SingleChildScrollView(
                  // Phần cuộn cho nội dung dưới title
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        //SizedBox(height: 5),
                        SearchBarApprovedWidget(patientDetail: widget.patientDetail),
                        PatientInfoSearch(patientDetail: widget.patientDetail),
                        AttachmentChecklist(patientDetail: widget.patientDetail),
                        AttachmentSectionSearchApproved(patientDetail: widget.patientDetail),
                       
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBarApproved(),
    );
  }
}
