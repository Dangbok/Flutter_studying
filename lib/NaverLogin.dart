import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:login_flutter2/profile_register_protector.dart';

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
    pageBuilder: (context, animation, secondaryAnimation) => const RegisterProfileProtector(),
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
