import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:login_flutter2/SocialLogin.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
          return true;
        } catch (e) {
          print('카카오톡으로 로그인 실패');
          return false;
        }
      } else{
        try{
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          return true;
        } catch(e) {
          print('카카오계정으로 로그인 실패');
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      print('정상적으로 로그아웃 되었습니다.');
      return true;
    } catch (error) {
      return false;
    }
  }
}
