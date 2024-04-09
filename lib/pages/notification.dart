import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/notifications/NotificationDetail.dart';
import 'package:pap_hd/notifications/NotificationService.dart';
import 'package:pap_hd/notifications/TitleNotification.dart'; // Để sử dụng DateFormat

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
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
                              title: Text(notification.title,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: notification.body,
                                      style: TextStyle(
                                          color:
                                              Colors.black), 
                                    ),
                                    TextSpan(
                                      text: '\n' +
                                          DateFormat('dd/MM/yyyy HH:mm').format(
                                              notification.receivedTime),
                                      style: TextStyle(
                                          color: Colors
                                              .grey),
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //      Container(
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage("assets/homeScreen/home_background.png"),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         child: ValueListenableBuilder<List<NotificationDetail>>(
  //           valueListenable: NotificationService().notificationDetails,
  //           builder: (context, notificationList, child) {
  //             if (notificationList.isEmpty) {
  //               return Center(child: Text("Không có thông báo mới"));
  //             }
  //             return ListView.builder(
  //               itemCount: notificationList.length,
  //               itemBuilder: (context, index) {
  //                 final notification = notificationList[index];
  //                 return Column(
  //                   children: [
  //                     ListTile(
  //                       title: Text(notification.title,
  //                           style: TextStyle(fontWeight: FontWeight.bold)),
  //                       subtitle: Text(
  //                         notification.body +
  //                             "\n" +
  //                             DateFormat('dd/MM/yyyy HH:mm')
  //                                 .format(notification.receivedTime),
  //                         style: TextStyle(color: Colors.grey),
  //                       ),
  //                       isThreeLine: true,
  //                       contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
  //                       trailing: IconButton(
  //                         icon: Icon(CupertinoIcons.delete,
  //                             size: 16, color: Colors.red),
  //                         onPressed: () {

  //                           NotificationService().removeNotificationAt(index);
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             SnackBar(
  //                               content: Text('Thông báo đã được xóa thành công'),
  //                               duration: Duration(
  //                                   seconds:
  //                                       2),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                     Divider(
  //                       color: Colors.teal.withOpacity(0.3),
  //                     ), // Thêm Divider
  //                   ],
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //       ],
  //     ),

  //   );
  // }
}
