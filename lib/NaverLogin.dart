import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:login_flutter2/profile_register_protector.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class NaverLoginButton extends StatefulWidget {
  const NaverLoginButton({Key? key}) : super(key: key);

  @override
  State<NaverLoginButton> createState() => _NaverLoginButtonState();
}

class _NaverLoginButtonState extends State<NaverLoginButton> {
  final storage = FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'].toString();
  final urlScheme = dotenv.env['URL_SCHEME'].toString();
  final naverRedirectUri = dotenv.env['NAVER_REDIRECT_URI'].toString();
  final naverAuthEndpoint =
  dotenv.env['NAVER_AUTHORIZATION_ENDPOINT'].toString();


  bool isLogin = false;
  String? name;
  String? email;
  String? accessToken;
  String? refreshToken;

  doNaverLogin() async {
    final url =
    Uri.parse('http://13.209.51.119:8080/oauth2/authorization/naver');
    // if (!await launchUrl(url)) {
    //   throw Exception('Could not launch $url');
    // }

    // final result = await Navigator.of(context).push(_createRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 45,
          width: 280,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ElevatedButton(
            onPressed: () {
              print('naver login');
              doNaverLogin();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromRGBO(3, 199, 90, 1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
            child: Image.asset(
              'assets/naver_login_btn.png',
              fit: BoxFit.fill,
              height: 45,
            ),
          ),
        ));
  }

  Future<void> signInWithNaver() async {
    try {
      final NaverLoginResult res = await FlutterNaverLogin.logIn();
      print(res);
      setState(() {
        isLogin = true;
        name = res.account.name;
        email = res.account.email;
        print(res.accessToken);
      });
      final result = await Navigator.of(context).push(_createRoute());
    } catch (err) {
      print(err);
    }
  }

  Future<void> signOut() async {
    try {
      await FlutterNaverLogin.logOut();
      setState(() {
        isLogin = false;
        name = null;
        email = null;
        accessToken = null;
      });
    } catch (err) {
      print(err);
    }
  }
}

// 페이지 전환 애니메이션
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    const RegisterProfileProtector(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 10.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
