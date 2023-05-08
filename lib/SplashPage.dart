import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:login_flutter2/MainPage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: new Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          body: new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 130,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('''
                  너의 이야기를,
                  우리의 추억을,
                  새로운 만남을''',
                    maxLines: 8,
                    style: TextStyle(
                      fontSize: screenWidth * (14/360),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.0001,),
                Container(
                  child: Image.asset('assets/ch_orange.png'),
                  margin: EdgeInsets.symmetric(vertical:80 ),
                ),
                // 카카오로그인
                // Container(
                //   margin: EdgeInsets.all(50),
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(Color(0xFFFCE301)),
                //     ),
                //     onPressed: () async {
                //       await viewModel.login();
                //       setState(() {});
                //       // 로그인 되면 MainPage로 화면 이동
                //       final result = await Navigator.pushNamed(context, '/main');
                //     },
                //     child: Image.asset('assets/kakao_login_medium_wide.png'),
                //     // child: const Text(
                //     //   '카카오톡으로 로그인하기',
                //     //   style: TextStyle(color: Colors.black),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    //   Scaffold(
    //   body: Stack(
    //     children: [
    //       LiquidSwipe(
    //           pages: pages)
    //     ],
    //   ),
    // );

  }
}


