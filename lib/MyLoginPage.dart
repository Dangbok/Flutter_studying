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
    return Scaffold(
      backgroundColor: Color(0xff8FDBA2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 유저 프로필사진 가져오기
            // Image.network(
            //     viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ''),
            Container(
                margin: EdgeInsets.all(50),
                padding: EdgeInsets.all(10),
                child: Image.asset('assets/logo_2@4x.png')),
            // 유저 로그인됐는지 확인 Text
            Text(
              '${viewModel.isLogined}',
              style: Theme.of(context).textTheme.headline4,
            ),
            // 카카오톡 로그인 버튼
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
    );
  }
}
