import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter2/Login_platform.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  LoginPlatform _loginPlatform = LoginPlatform.none;


  // Future<OAuthToken> loginWithKakaoAccount({
  //   List<Prompt>? prompts,
  //   List<String>? channelPublicIds,
  //   List<String>? serviceTerms,
  //   String? loginHint,
  //   String? nonce,
  // }) async {
  //   String codeVerifier = AuthCodeClient.codeVerifier();
  //   final authCode = await AuthCodeClient.instance.request(
  //     prompts: prompts,
  //     channelPublicIds: channelPublicIds,
  //     serviceTerms: serviceTerms,
  //     codeVerifier: codeVerifier,
  //     loginHint: loginHint,
  //     nonce: nonce,
  //   );
  //   final token = await AuthApi.instance
  //       .issueAccessToken(authCode: authCode, codeVerifier: codeVerifier);
  //   await TokenManagerProvider.instance.manager.setToken(token);
  //   return token;
  // }


  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }


  // void _get_user_info() async {
  //   try {
  //     User user = await UserApi.instance.me();
  //     print('사용자 정보 요청 성공'
  //         '\n회원번호: ${user.id}'
  //         '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
  //   } catch (error) {
  //     print('사용자 정보 요청 실패 $error');
  //   }
  // }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '다시,봄',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
//       body: Center(
//           child: ElevatedButton(
//             child: const Text('kakaologin'),
//             onPressed: () async {
//               // print(await KakaoSdk.origin);
//               loginWithKakaoAccount();
//             },
//           )),
//     );
//   }
// }

      body: Center(
          child: _loginPlatform != LoginPlatform.none
              ? _logoutButton()
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loginButton(
                'kakao_logo',
                signInWithKakao,
              )
            ],
          )),
    );
  }

  // body: Container(
  //     color: Colors.white,
  //     child: Center(
  //       child: ElevatedButton(
  //           child: Text("카카오 로그인"),
  //           onPressed: () async {
  //             if (await isKakaoTalkInstalled()) {
  //               try {
  //                 await UserApi.instance.loginWithKakaoTalk();
  //                 print('카카오톡으로 로그인 성공');
  //                 _get_user_info();
  //               } catch (error) {
  //                 print('카카오톡으로 로그인 실패 $error');
  //                 // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
  //                 try {
  //                   await UserApi.instance.loginWithKakaoAccount();
  //                   print('카카오계정으로 로그인 성공');
  //                   _get_user_info();
  //                 } catch (error) {
  //                   print('카카오계정으로 로그인 실패 $error');
  //                 }
  //               }
  //             } else {
  //               try {
  //                 await UserApi.instance.loginWithKakaoAccount();
  //                 print('카카오계정으로 로그인 성공');
  //                 _get_user_info();
  //               } catch (error) {
  //                 print('카카오계정으로 로그인 실패 $error');
  //               }
  //             }
  //           }),
  //     )),
//   );
// }}

  Widget _loginButton(String path, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage('assets/$path.jpg'),
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

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff0165E1),
        ),
      ),
      child: const Text('로그아웃'),
    );
  }
}