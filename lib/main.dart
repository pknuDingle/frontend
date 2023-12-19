import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login_page.dart';
import 'firebase_option.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterLocalNotificationsPlugin 초기화
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(const AndroidNotificationChannel(
    'high_importance_channel',
    'high_importance_notification',
    importance: Importance.max,
  ));

  // 푸시 메시지에서 알림을 생성하고 표시하는 로직
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'high_importance_channel', // 채널 ID
    'High Importance Notifications', // 채널 이름
    importance: Importance.max,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  // 메시지 데이터에서 알림 내용과 제목 가져오기
  final String? title = message.notification?.title;
  final String? content = message.notification?.body;

  if (title != null && content != null) {
    // 30글자까지만 보여주는 알림
    await flutterLocalNotificationsPlugin.show(
      0, // 알림 ID
      title, // 제목
      content.length > 30 ? '${content.substring(0, 30)}...' : content, // 본문 30글자로 제한
      platformChannelSpecifics, // 알림 설정
    );
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
    'high_importance_channel',
    'high_importance_notification',
    importance: Importance.max,
  ));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}