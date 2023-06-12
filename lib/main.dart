import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:login_flutter2/MainPage.dart';
import 'package:login_flutter2/OnbardingPage.dart';
import 'package:login_flutter2/SplashPage.dart';
import 'package:login_flutter2/profile_register_protector.dart';
import 'package:login_flutter2/profile_register_animal.dart';

void main() async {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '0f1772d6ba49dbd308c3df9873edf6e1',
  );
  // 로고 스플래시 호출
  await initialization(null);
  // FlutterNativeSplash.removeAfter(initialization);

  runApp(const MyApp());
}

// 로고 스플래시 구현
Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 1));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dasi-bom',
      theme: ThemeData(primaryColor: Colors.white),
      home: RegisterProfileProtector(),
      // 라우터로 페이지 이동
      routes: {
        '/login': (context) => OnbardingPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}
