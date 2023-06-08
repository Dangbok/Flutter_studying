import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_flutter2/OnbardingPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  // 스플래시 화면 로딩 후 온보딩 & 로그인 화면으로 이동
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
    ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => OnbardingPage())));
  }

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
              새로운 만남을
                  ''',
                    maxLines: 8,
                    style: TextStyle(
                        fontSize: screenWidth * (16/360),
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''           유기동물 임시보호 일지''',
                    maxLines: 8,
                    style: TextStyle(
                        fontSize: screenWidth * (20/360),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''      다시, 봄''',
                    maxLines: 10,
                    style: TextStyle(
                        fontSize: screenWidth * (35/360),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.0001,),
                Container(
                  child: Image.asset('assets/ch_yellow.png'),
                  margin: EdgeInsets.symmetric(vertical:130, horizontal: 20 ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



