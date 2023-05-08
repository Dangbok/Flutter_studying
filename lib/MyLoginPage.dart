import 'package:flutter/material.dart';
import 'package:login_flutter2/Kakao_login.dart';
import 'package:login_flutter2/main_view_model.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // 로그인 생성자 생성
  final viewModel = MainViewModel(KakaoLogin());

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
                    child: Text(
                      '''      유기동물 임시보호 일지
      다시, 봄''',
                      maxLines: 8,
                      style: TextStyle(
                        fontSize: screenWidth * (20/360),
                        fontWeight: FontWeight.bold
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
                  Container(
                    margin: EdgeInsets.all(50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFFCE301)),
                      ),
                      onPressed: () async {
                        await viewModel.login();
                        setState(() {});
                        // 로그인 되면 MainPage로 화면 이동
                        final result = await Navigator.pushNamed(context, '/main');
                      },
                      child: Image.asset('assets/kakao_login_medium_wide.png'),
                      // child: const Text(
                      //   '카카오톡으로 로그인하기',
                      //   style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
