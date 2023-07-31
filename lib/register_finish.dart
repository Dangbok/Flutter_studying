import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter2/writing.dart';

import 'MainPage.dart';

class RegisterFinish extends StatefulWidget {
  const RegisterFinish({Key? key}) : super(key: key);

  @override
  State<RegisterFinish> createState() => _RegisterFinishState();
}

class _RegisterFinishState extends State<RegisterFinish> {
  // 가입 완료 폭죽 효과
  bool isPlaying = false;
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 5));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            children: <Widget>[
              buildConfetti(),
            ],
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                '''프로필 등록이 
완료되었습니다!''',
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                '''글린다님 반가워요!
오늘부터 카야와 
소중한 일상을 나눠주세요!''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/user1.png'),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/ic_heart.png'),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/user2.png'),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            width: 350,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
                backgroundColor:
                MaterialStateProperty.all(Color(0xFFFFED8E)),
              ),
              onPressed: () => setState(
                    () async {
                  // 홈 화면으로 이동
                  final result =
                  await Navigator.of(context).push(_createRoute());
                },
              ),
              child: Text(
                "다시,봄 시작하기",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 폭죽 효과 애니메이션
  Widget buildConfetti() => Align(
        alignment: Alignment.center,
        child: ConfettiWidget(
          confettiController: _controller,
          blastDirectionality: BlastDirectionality.explosive,
          colors: [
            Colors.red,
            Colors.blue,
            Colors.orange,
            Colors.yellow,
            Colors.pink,
            Colors.green,
          ],
          shouldLoop: true,
        ),
      );

  // 페이지 전환 애니메이션
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 10.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
