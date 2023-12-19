import 'package:capstone_dingle/model/sociallogin.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;
  String? accessToken;
  String? fcmToken;

  MainViewModel(this._socialLogin, this.fcmToken);

  Future<bool> oauthLogin() async {
    bool loginSuccess = await _socialLogin.oauthLogin();
    if (loginSuccess) {
      try {
        user = await UserApi.instance.me();
        isLogined = true;
        accessToken = await _socialLogin.getAccessToken();
      } catch (e) {
        print('사용자 정보를 가져오는 데 실패: $e');
        isLogined = false;
      }
    } else {
      isLogined = false;
    }
    return isLogined;
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
    accessToken = null;
  }

  // 액세스 토큰을 반환하는 메서드
  String? getAccessToken() {
    print(accessToken);
    return accessToken;
  }
}
