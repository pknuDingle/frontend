import 'package:capstone_dingle/Widget/login_view.dart';
import 'package:flutter/material.dart';
import '../model/list_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/member_model.dart';
import '../pickhomepage.dart';
import 'kakao_login.dart';


class MyPageWidget extends StatefulWidget{
  final List<Map<String, dynamic>> userKeywords;
  final Member member;

  MyPageWidget({required this.userKeywords, required this.member});

  @override
  State<StatefulWidget> createState() => _MyPageWidgetState();

}

class _MyPageWidgetState extends State<MyPageWidget> {
  @override
  final viewModel = MainViewModel(KaKaoLogin());
  Widget build(BuildContext context) {
    bool isUserLoggedIn = viewModel.isLogined;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 120,
                decoration:BoxDecoration(
                  color: Color(0xff9BBDFF),
                  borderRadius : BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  bool loggedIn = await viewModel.oauthLogin();
                  if (loggedIn) {
                    print("멤버jwt는: ${widget.member?.jwt}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickHomePage(member: widget.member), // user 정보 전달
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
                  : Text('로그인안됐는디'),
            ],
          ),
        ),
      ),
    );
  }


}


