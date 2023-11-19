import 'dart:convert';
import 'dart:io';

import 'package:capstone_dingle/home_page.dart';
import 'package:capstone_dingle/pickhomepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'Widget/kakao_login.dart';
import 'Widget/login_view.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final viewModel = MainViewModel(KaKaoLogin());




  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = viewModel.isLogined;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('홈으로')),
          Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl??''),
          isUserLoggedIn
              ? ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PickHomePage()));
            },
            child: Text('키워드 설정 시작'),
          )
              : SizedBox(),
          Row(
            children: [
              InkWell(
                onTap: ()async{
                  await viewModel.oauthLogin();
                  setState(() {

                  });
                },
                child: Image.asset('assets/kakao_logo.png',
                  width: 170,
                  height: 30,),
              ),
              InkWell(
                onTap: ()async{
                  await viewModel.logout();
                  setState(() {});
                },
                child: Text(
                    'Logout'
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}