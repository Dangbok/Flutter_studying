import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter2/Login_platform.dart';
import 'package:login_flutter2/MainPage.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // 로고 버튼을 눌러 로그인을 실행하고 로그아웃 버튼으로 로그아웃 처리
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithKakao() async {
    try {
      // 카카카오톡 설치여부 확인
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          // 카카오톡 설치되어 있다면 카카오톡 실행하여 로그인
          ? await UserApi.instance.loginWithKakaoTalk()
          // 카카오톡 설치되지 않았다면 웹으로 로그인 진행
          : await UserApi.instance.loginWithKakaoAccount();

      // 유저정보 확인을 http 패키지로 진행
      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      // 로그인 성공시 OAuthToken으로 acessToken 값 받아올 수 있음
      // 이 토큰 값으로 유저정보를 확인하는 요청을 보내면 이름과 이메일 정보얻음
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      // 로그인 상태값 갱신
      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });

        final result = await Navigator.pushNamed(context, '/main');

    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  // 로그아웃 처리 함수
  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.none:
        break;
    }

    // 로그인 상태값을 false로, 현재 로그인 플랫폼을 none으로 갱신
    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '다시,봄',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
            child: _loginPlatform != LoginPlatform.none
                ? _logoutButton()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _loginButton(
                        signInWithKakao,
                      ),
                    ],
                  )),
      ),
    );
  }

  Widget _loginButton(VoidCallback onTap) {
    // 로그인 처리 함수 받기
    // 그림자 효과주기 위해 Card 사용
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage('assets/img.jpg'),
        width: 60,
        height: 60,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(35.0),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  // Widget _logoutButton() {
  //   return ElevatedButton(
  //     onPressed: signOut,
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(
  //         const Color(0xff0165E1),
  //       ),
  //     ),
  //     child: const Text('로그아웃'),
  //   );
  // }
}
