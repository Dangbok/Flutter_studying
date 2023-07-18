import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLoginButton extends StatefulWidget {
  const NaverLoginButton({Key? key}) : super(key: key);

  @override
  State<NaverLoginButton> createState() => _NaverLoginButtonState();
}

class _NaverLoginButtonState extends State<NaverLoginButton> {
  bool isLogin = false;
  String? name;
  String? email;
  String? accessToken;
  String? refreshToken;

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
              signInWithNaver();
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
      final result = await Navigator.pushNamed(context, '/main');
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
