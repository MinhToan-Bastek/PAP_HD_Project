
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pap_hd/api/firebase_api.dart';
import 'package:pap_hd/components/bottomNavBar/bottomNavBar.dart';
import 'package:pap_hd/model/checkbox_provider.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/model/img_provider.dart';
import 'package:pap_hd/notifications/NotificationService.dart';
import 'package:pap_hd/pages/login.dart';
import 'package:provider/provider.dart';


//Nhận thông báo khi màn hình tắt
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  handleIncomingNotification(message);
}
void handleIncomingNotification(RemoteMessage message) {
  String title = message.notification?.title ?? "Thông báo mới";
  String body = message.notification?.body ?? "Bạn có một thông báo mới";
  
  NotificationService().addNotification(title, body);
}



void main() async {
    
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
   Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDn0V9cUlfeCZ_PyPO1pmuO2IpjBYfawS8', 
      appId: '1:358887818301:android:e363b8faf7053a751c1654', 
      messagingSenderId: '358887818301', 
      projectId: 'pap-project-9b4ad'  
      )
  )
  : 
  await Firebase.initializeApp();
   // Khởi tạo Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // Nhận thông báo khi màn hình tắt
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  // Nhận thông báo khi màn hình bật
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    handleIncomingNotification(message);
    print("Got a message whilst in the foreground!");
    print("Message data: ${message.data}");
    if (message.notification != null) {
      print("Message also contained a notification: ${message.notification?.title}");
    }
  });


  runApp(const MyApp());
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
