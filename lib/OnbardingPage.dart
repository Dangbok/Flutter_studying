import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:login_flutter2/MyLoginPage.dart';
import 'package:login_flutter2/MainPage.dart';
import 'package:login_flutter2/Kakao_login.dart';
import 'package:login_flutter2/main_view_model.dart';
import 'package:login_flutter2/NaverLogin.dart';
import 'package:login_flutter2/profile_register_protector.dart';

class OnbardingPage extends StatefulWidget {
  const OnbardingPage({Key? key}) : super(key: key);

  @override
  State<OnbardingPage> createState() => _OnbardingPageState();
}

class _OnbardingPageState extends State<OnbardingPage> {
  // 로그인 생성자 생성
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {

    // 화면 크기
    Size screenSize(BuildContext context) {
      return MediaQuery.of(context).size;
    }
    // 화면 높이
    double screenHeight(BuildContext context, {double dividedBy = 1}) {
      return screenSize(context).height / dividedBy;
    }
    // 화면 너비
    double screenWidth(BuildContext context, {double dividedBy = 1}) {
      return screenSize(context).width / dividedBy;
    }
    //상단 툴바를 제외한 화면 높이
    double screenHeightExcludingToolbar(BuildContext context,
        {double dividedBy = 1}) {
      return screenHeight(context, dividedBy: dividedBy);
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // 온보딩
          SizedBox(
            height: 535,
            child: Container(
              child: IntroductionScreen(
                pages: [
                  PageViewModel(
                    reverse: true,
                      title: '안녕하세요!',
                      body: '''건강하고 재밌게,
  임시보호를 기록하는 다시, 봄이에요''',
                      image: Image.asset('assets/dasibom_orange.png'),
                      decoration: getPageDecoration()),
                  PageViewModel(
                      reverse: true,
                      title: '기록하기',
                      body: '''다시, 봄 챌린지에 참여하고
 동물 친구들의 귀여운 모습을 
 마음껏 자랑해요''',
                      image: Image.asset('assets/dasibom_yellow.png'),
                      decoration: getPageDecoration()),
                  PageViewModel(
                      reverse: true,
                      title: '추억하기',
                      body: '''임시보호가 끝나도 
 추억을 다시 돌아볼 수 있어요
 어떤 재밌는 일이 일어날지
 지금 바로 시작해 보세요!''',
                      image: Image.asset('assets/dasibom_orange.png'),
                      decoration: getPageDecoration()),
                ],
                done: const Text('done'),
                // Onboarding page가 끝나면 어떻게 할 지
                onDone: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyLoginPage()));
                },
                next: const Icon(Icons.arrow_forward),
                // skip 버튼 추가
                showSkipButton: true,
                skip: Text('skip'),
                // page 표시하는 dot 꾸미기
                dotsDecorator: DotsDecorator(
                    color: Colors.grey,
                    size: const Size(10, 10),
                    // active 상태인 dot 꾸미기
                    activeColor: Colors.orange,
                    activeSize: Size(22, 10),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                // 애니메이션 효과 적용
                curve: Curves.ease,
              ),
            ),
          ),
          // 카카오 로그인
          SizedBox(
            child: Container(
              height: 45,
              width: 280,
              margin: EdgeInsets.only(top: 40,bottom: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFFCE301)),
                ),
                onPressed: () async {
                  await viewModel.login();
                  setState(() {});
                  // 로그인 되면 MainPage로 화면 이동
                  final result = await Navigator.of(context).push(_createRoute());
                },
                child: Image.asset('assets/btn_kakao.png'),
              ),
            ),
          ),
          // 네이버 로그인
          SizedBox(
            child: NaverLoginButton(),
          ),
          // 둘러보기
          SizedBox(
            child: Container(
              height: 25,
              color: Colors.white,
              margin: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: (){},
                child: Text(
                  "둘러보기",
                  style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600),),
              ),
            ),
          ),
        ],
      ),
    );
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

// PageViewModel의 이미지 decoration 인자 값으로 주기 위한 메서드
PageDecoration getPageDecoration() {
  return PageDecoration(
      // title 스타일
      titlePadding: EdgeInsets.only(top: 50),
      bodyAlignment:Alignment.topCenter,
      titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      // 본문 스타일
      bodyPadding: EdgeInsets.only(top: 20),
      bodyTextStyle: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      imageAlignment: Alignment.bottomCenter,
      imagePadding: EdgeInsets.only(top: 50),
      pageColor: Color(0xFFF8F8F9));
}
