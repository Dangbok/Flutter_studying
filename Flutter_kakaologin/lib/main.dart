import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

// import 'package:kakao_flutter_sdk/all.dart';
// import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '0f1772d6ba49dbd308c3df9873edf6e1',
    javaScriptAppKey: '19ef6355b4d2cb8afc9c439c165794be',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            color: Colors.white,
            child: Center(
                child: ElevatedButton(
                    child: Text("카카오 로그인"),
                    onPressed: () async {
                      if (await isKakaoTalkInstalled()) {
                        try {
                          await UserApi.instance.loginWithKakaoTalk();
                          print('카카오톡으로 로그인 성공');
                          _get_user_info();
                        } catch (error) {
                          print('카카오톡으로 로그인 실패 $error');
                          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                          try {
                            await UserApi.instance.loginWithKakaoAccount();
                            print('카카오계정으로 로그인 성공');
                            _get_user_info();
                          } catch (error) {
                            print('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      } else {
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          print('카카오계정으로 로그인 성공');
                          _get_user_info();
                        } catch (error) {
                          print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    }))));
  }
}

