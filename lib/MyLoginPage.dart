import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:login_flutter2/Kakao_login.dart';
import 'package:login_flutter2/MainPage.dart';
import 'package:login_flutter2/main_view_model.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final viewModel=MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("다시, 봄"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ''),
            Text('${viewModel.isLogined}',
              style: Theme.of(context).textTheme.headline4,),
            ElevatedButton(
                onPressed: () async {
                  await viewModel.login();
                  setState(() {});
                  final result = await Navigator.pushNamed(context, '/main');
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
