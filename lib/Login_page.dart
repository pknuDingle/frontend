import 'dart:convert';
import 'dart:io';

import 'package:capstone_dingle/home_page.dart';
import 'package:capstone_dingle/pickhomepage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'Provider/member_provider.dart';
import 'Widget/kakao_login.dart';
import 'Widget/login_view.dart';
import 'apis.dart';
import 'model/member_model.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Member? member;
  var messageString = "";
  late String _fcmToken = '';

  Future<void> getMyDeviceToken() async {
    final fcmtoken = await FirebaseMessaging.instance.getToken();
    print("내 fcm토큰:$fcmtoken");
    setState(() {
      _fcmToken = fcmtoken ?? ""; // fcmToken 값을 가져와서 저장
    });
  }

  late MainViewModel viewModel;

  void initState() {
    super.initState();
    getMyDeviceToken();
    viewModel = MainViewModel(KaKaoLogin(), _fcmToken);
    print("왜안될까요???");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        showNotification(notification.title ?? '', notification.body ?? '');
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
          print('앱 내부 알림 도착${message.data}');
        });

        // 포그라운드에서 메시지를 받으면 AlertDialog를 표시
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(notification.title ?? ''),
              content: Text(
                notification.body != null && notification.body!.length > 30
                    ? '${notification.body!.substring(0, 30)}...'
                    : notification.body ?? '',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      }else{print('실패');}
    });

    getSavedMemberInfo().then((retrievedMember) {
      setState(() {
        if (retrievedMember != null) {
          _redirectToPage(retrievedMember);
        }
      });
    });
  }

  void showNotification(String title, String body) {
    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body.length > 30 ? '${body.substring(0, 30)}...' : body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'high_importance_notification',
          importance: Importance.max,
        ),
      ),
      payload: body,
    );
  }

  void _redirectToPage(Member? member) async {
    if (member != null) {
      List<Map<String, dynamic>>? userKeywords = await APIs.getUserKeywords(member!.jwt);

      if (userKeywords != null && userKeywords.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(member: member!, userKeywords: userKeywords),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PickHomePage(member: member!),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = viewModel.isLogined;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top:300,bottom: 20, right: 110, left: 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl??''),
            Text('DINGLE',style: TextStyle(fontSize: 50, color: Color(0xff9BBDFF)), ),
            SizedBox(height: 50),
            Column(
                children: [
                  InkWell(
                    onTap: () async {
                      bool loggedIn = await viewModel.oauthLogin();
                      if (loggedIn) {
                        print("멤버jwt는: ${member?.jwt}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PickHomePage(member: member), // user 정보 전달
                          ),
                        );
                      } else {
                        print("페이지 이동실패");
                      }
                    },
                    child: Image.asset('assets/kakao_logo.png',
                      width: 170,
                      height: 30,),
                  ),
                  isUserLoggedIn
                      ? InkWell(
                    onTap: ()async{
                      await viewModel.logout();
                      setState(() {});
                    },
                    child: Text(
                        'Logout'
                    ),
                  )
                      : SizedBox(),
                ],
              ),

          ],
        ),
      ),
    );
  }

}