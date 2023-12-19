import 'package:capstone_dingle/model/sociallogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../Provider/member_provider.dart';
import '../apis.dart';
import '../model/member_model.dart';
import '../pickhomepage.dart';

class KaKaoLogin implements SocialLogin {
  late String _fcmtoken;
  @override
  Future<bool> isLoggedIn() async {
    try {
      // 회원 정보 가져오기 시도
      User user = await UserApi.instance.me();

      // 회원 정보가 있는 경우 로그인 상태로 판단
      bool loggedIn = user != null;
      return loggedIn;
    } catch (error) {
      // 회원 정보를 가져오는 데 실패하면 로그인 상태를 확인할 수 없다고 판단
      print('로그인 상태 확인 실패: $error');
      return false;
    }
  }

  @override
  Future<bool> oauthLogin() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          final oauthToken = await UserApi.instance.loginWithKakaoTalk();
          print("액세스 토큰: ${oauthToken.accessToken}"); // 액세스 토큰 출력
          Member? member = await APIs.signInWithKakao(oauthToken.accessToken, _fcmtoken);
          print('뭔데뭔데${member?.jwt ?? 'member 객체가 null입니다.'}');
          if (member != null) {
            await saveMemberInfo(member);
            print('멤버는 내용이뭘까요${member.jwt}');
          }
          return true;
        } catch (e) {
          print('카카오톡으로 로그인 실패 $e');
          return false;
        }
      } else {
        try {
          print('카카오계정으로 로그인 성공');
          final kakaoToken = await UserApi.instance.loginWithKakaoAccount();
          print("액세스 토큰: ${kakaoToken.accessToken}"); // 액세스 토큰 출력
          Member? member = await APIs.signInWithKakao(kakaoToken.accessToken, _fcmtoken);
          print('뭔데뭔데${member?.jwt ?? 'member 객체가 null입니다.'}');
          if (member != null) {
            await saveMemberInfo(member);
            print('멤버는 내용이뭘까요${member}');
          }
          return true;
        } catch (e) {
          print('카카오계정으로 로그인 실패 $e');
          return false;
        }
      }
    } catch (e) {
      print('카카오계정으로 로그인 실패 $e');
      return false;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      if (isInstalled) {
        final oauthToken = await UserApi.instance.loginWithKakaoTalk();
        print('성공ㅎㅎ');
        return oauthToken.accessToken;
      } else {
        final kakaoToken = await UserApi.instance.loginWithKakaoAccount();
        return kakaoToken.accessToken;
      }
    } catch (e) {
      print('엑세스 토큰을 가져오는 데 실패했습니다: $e');
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      // 로그아웃 성공 시 처리
      return true;
    } catch (e) {
      // 로그아웃 실패 시 처리
      print('로그아웃실패: $e');
      return false;
    }
  }
}


