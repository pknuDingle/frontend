import 'package:capstone_dingle/model/sociallogin.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MainViewModel{
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future oauthLogin() async{
    isLogined = await _socialLogin.oauthLogin();
    if(isLogined){
      user= await UserApi.instance.me();
    }
  }

  Future logout() async{
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

}