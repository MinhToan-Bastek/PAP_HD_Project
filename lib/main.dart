



//Nhận thông báo khi màn hình tắt
// Future<void> backgroundMessageHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   handleIncomingNotification(message);
// }
// void handleIncomingNotification(RemoteMessage message, String currentUsername) {
//   String title = message.notification?.title ?? "Thông báo mới";
//   String body = message.notification?.body ?? "Bạn có một thông báo mới";

//   // Log the notification or handle it in another way if needed
//   print("Received notification: $title - $body");

//   // Refresh the notification list from the API using the current username
//   NotificationService().loadNotifications();
// }




// // Biến global để lưu currentUsername
// String currentUsername = '';


// void main() async {
    
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//    Platform.isAndroid?
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: 'AIzaSyDn0V9cUlfeCZ_PyPO1pmuO2IpjBYfawS8', 
//       appId: '1:358887818301:android:e363b8faf7053a751c1654', 
//       messagingSenderId: '358887818301', 
//       projectId: 'pap-project-9b4ad'  
//       )
//   )
//   : 
//   await Firebase.initializeApp();
//    // Khởi tạo Firebase Analytics
//   FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//   // // Nhận thông báo khi màn hình tắt
//   // FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

//   // // Nhận thông báo khi màn hình bật
//   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //   handleIncomingNotification(message);
//   //   print("Got a message whilst in the foreground!");
//   //   print("Message data: ${message.data}");
//   //   if (message.notification != null) {
//   //     print("Message also contained a notification: ${message.notification?.title}");
//   //   }
//   // });
//   // Lấy username từ SharedPreferences
  

//   runApp(const MyApp());
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeFirebase();
//   final String currentUsername = await getCurrentUsername();
//   setupFirebaseMessagingHandlers(currentUsername);
//   runApp(const MyApp());
//    // Tải thông báo sau khi ứng dụng khởi động
//   NotificationService().loadNotifications();
// }

// Future<void> initializeFirebase() async {
//   if (Platform.isAndroid) {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//        apiKey: 'AIzaSyDn0V9cUlfeCZ_PyPO1pmuO2IpjBYfawS8', 
//       appId: '1:358887818301:android:e363b8faf7053a751c1654', 
//       messagingSenderId: '358887818301', 
//       projectId: 'pap-project-9b4ad'  
//       )
//     );
//   } else {
//     await Firebase.initializeApp();
//   }
//   FirebaseAnalytics.instance; // Instance for analytics
// }

// Future<String> getCurrentUsername() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('username') ?? '';
// }

// void setupFirebaseMessagingHandlers(String username) {
//   FirebaseMessaging.onBackgroundMessage((message) => backgroundMessageHandler(message, username));
//   FirebaseMessaging.onMessage.listen((message) => onMessageHandler(message, username));
// }

// Future<void> backgroundMessageHandler(RemoteMessage message, String username) async {
//   print("Handling a background message: ${message.messageId}");
//   handleIncomingNotification(message, username);
// }

// void onMessageHandler(RemoteMessage message, String username) {
//   print("Handling a foreground message: ${message.messageId}");
//   if (message.notification != null) {
//     print("Message also contained a notification: ${message.notification?.title}");
//     // Cập nhật UI hoặc trạng thái ứng dụng tại đây nếu cần
//     handleIncomingNotification(message, username);
//   }
// }

// void handleIncomingNotification(RemoteMessage message, String username) {
//   String title = message.notification?.title ?? "Thông báo mới";
//   String body = message.notification?.body ?? "Bạn có một thông báo mới";
//   print("Received notification: $title - $body");

//   // Làm mới số lượng thông báo và dữ liệu
//   NotificationService().incrementNotificationCount();
//   NotificationService().fetchAndLoadNotifications(username);
// }


import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pap_hd/api/firebase_api.dart';
import 'package:pap_hd/components/bottomNavBar/bottomNavBar.dart';
import 'package:pap_hd/model/checkbox_createADR.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/model/img_provider.dart';
import 'package:pap_hd/notifications/NotificationService.dart';
import 'package:pap_hd/notifications/flushBar.dart';
import 'package:pap_hd/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Since the background handler doesn't involve user interactions, you might want to update data or show a notification
  print("Background Notification: ${message.notification?.title}, ${message.notification?.body}");
  NotificationService().loadNotificationCount();  // This function should be adjusted to not require username globally or handle it via shared prefs
}

void handleIncomingNotification(RemoteMessage message, String username) {
  String title = message.notification?.title ?? "Thông báo mới";
  String body = message.notification?.body ?? "Bạn có một thông báo mới";
  print("Received notification: $title - $body");
  // Assuming NotificationService can handle username internally or it's set globally
  NotificationService().incrementNotificationCount();
  NotificationService().fetchAndLoadNotifications(username);
}

// void setupFirebaseMessagingHandlers(String username) {
//   FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);  // Corrected this line
//   FirebaseMessaging.onMessage.listen((message) => onMessageHandler(message, username));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print("Got a message whilst in the foreground!");
  print("Message data: ${message.data}");

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }

  // Handling notification
  String title = message.notification?.title ?? "No Title";
  String body = message.notification?.body ?? "No Body";
  String id = message.data['id'].toString();

  // Displaying the notification
  //showNotificationFlushbar(context, title, body, id);
});

  final String currentUsername = await getCurrentUsername();
  //setupFirebaseMessagingHandlers(currentUsername);
   initializeDateFormatting().then((_) => runApp(MyApp()));

  //NotificationService().loadNotifications(); // Better to move inside MyApp for lifecycle management
}

Future<void> initializeFirebase() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDn0V9cUlfeCZ_PyPO1pmuO2IpjBYfawS8',
        appId: '1:358887818301:android:e363b8faf7053a751c1654',
        messagingSenderId: '358887818301',
        projectId: 'pap-project-9b4ad'
      )
    );
  } else {
    await Firebase.initializeApp();
  }
  FirebaseAnalytics.instance; // Consider capturing instance for further use or logging
}

Future<String> getCurrentUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? 'default_username';
}

void onMessageHandler(RemoteMessage message, BuildContext context, String username) {
  print("Handling a foreground message: ${message.messageId}");
  if (message.notification != null) {
    // Correctly passing BuildContext to the showNotificationFlushbar
    //showNotificationFlushbar(context, message.notification?.title ?? "New Message", message.notification?.body ?? "You have a new message");
    print("Foreground Notification: ${message.notification?.title}, ${message.notification?.body}");
    handleIncomingNotification(message, username);
  }
}







class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImageProviderModel()),
        ChangeNotifierProvider(create: (context) => DocumentsData()), 
        ChangeNotifierProvider(create: (context) => DocumentImagesProvider()), 
        ChangeNotifierProvider(create: (context) => DocumentsDataUpdate()),
        ChangeNotifierProvider(create: (context) => DocumentsDataCreateADR()),  
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
