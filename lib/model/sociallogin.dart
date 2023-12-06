import 'package:flutter/cupertino.dart';

abstract class SocialLogin{
  Future<bool> isLoggedIn();
  Future<bool> oauthLogin();
  Future<bool> logout();

  Future<String?> getAccessToken();


}