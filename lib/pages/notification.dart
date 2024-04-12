import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/notifications/NotificationDetail.dart';
import 'package:pap_hd/notifications/NotificationService.dart';
import 'package:pap_hd/notifications/TitleNotification.dart';
import 'package:pap_hd/pages/patient_search.dart';
import 'package:pap_hd/pages/patient_searchApproved.dart';
import 'package:pap_hd/services/api_service.dart'; // Để sử dụng DateFormat

class NotificationsPage extends StatefulWidget {
  final String username;
  final String pid;
  final String name;
  final String tenChuongTrinh;

  const NotificationsPage({super.key, required this.username, required this.pid, required this.name, required this.tenChuongTrinh});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}


class _NotificationsPageState extends State<NotificationsPage> {
  @override
void initState() {
  super.initState();
  NotificationService().loadNotifications();
}

 
 final ApiService apiService = ApiService(); // Tạo đối tượng ApiService

 void handleNotificationTap(NotificationDetail notification) async {
  String patientCode = notification.parsePatientCode();
  try {
    int patientId = await apiService.fetchPatientIdd(patientCode, widget.username);
    final patientDetail = await ApiService().getPatientById(patientId.toString());
    int tinhTrang = int.parse(patientDetail['TinhTrang']);

    if (tinhTrang == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PatientSearchScreen(
          patientDetail: patientDetail,
          username: widget.username,
          id: patientId.toString(),
          pid: widget.pid,
          name: widget.name,
          tenChuongTrinh: widget.tenChuongTrinh,
        ),
      ));
    } else if (tinhTrang > 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PatientSearchApprovedScreen(
          patientDetail: patientDetail,
          username: widget.username,
          tenChuongTrinh: widget.tenChuongTrinh,
        ),
      ));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error fetching patient data: $e'),
      ),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền cho toàn bộ màn hình
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
              TitleNotification(),
              Expanded(
                child: ValueListenableBuilder<List<NotificationDetail>>(
                  valueListenable: NotificationService().notificationDetails,
                  builder: (context, notificationList, child) {
                    if (notificationList.isEmpty) {
                      return Center(child: Text("Không có thông báo mới"));
                    }
                    return ListView.builder(
                      itemCount: notificationList.length,
                      itemBuilder: (context, index) {
                        final notification = notificationList[index];
                        return Column(
                          children: [
                            ListTile(
                               onTap: () => handleNotificationTap(notificationList[index]),
                              leading: Padding(
                                padding: const EdgeInsets.only(right: 2, top: 4),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Colors.teal,
                                  child: Stack(
                                    clipBehavior: Clip
                                        .none, 
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            'assets/profile.png'), // Ảnh lớn
                                      ),
                                      Positioned(
                                        right:
                                            -12, 
                                        bottom:
                                            -5, 
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors
                                              .white, 
                                          backgroundImage: AssetImage(
                                              'assets/ic_edit.png'), // Ảnh nhỏ
                                        ),
                                      ),
                                    ],
                                  ),
                                   
                                ),
                              ),
                              title: Text(notification.title,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: notification.body,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: '\n' +
                                          DateFormat('dd/MM/yyyy HH:mm').format(
                                              notification.receivedTime),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              isThreeLine: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                              trailing: IconButton(
                                icon: Icon(CupertinoIcons.delete,
                                    size: 16, color: Colors.red),
                                onPressed: () {
                                  NotificationService()
                                      .removeNotificationAt(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Thông báo đã được xóa thành công'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Divider(
                              color: Colors.teal.withOpacity(0.3),
                            ),
                          ],
                        );
                      },
                    );
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
