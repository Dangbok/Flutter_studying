import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:login_flutter2/SocialLogin.dart';

class MainViewModel{
  final SocialLogin _socialLogin;
  bool isLogined =false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined=await _socialLogin.login();
    if(isLogined){
        user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user?.id}'
            '\n닉네임: ${user?.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user?.kakaoAccount?.email}'
            '\n성별: ${user?.kakaoAccount?.gender}'
            '\n연령대: ${user?.kakaoAccount?.ageRange}');
    }
  }
   Future logout() async{
    await _socialLogin.logout();
    isLogined=false;
    user=null;
   }
}