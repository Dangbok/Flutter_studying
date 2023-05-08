import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:login_flutter2/MyLoginPage.dart';
import 'package:login_flutter2/MainPage.dart';

class OnbardingPage extends StatelessWidget {
  const OnbardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: '안녕하세요!',
            body: '''건강하고 특별하게,
  동물친구들과 하루를 기록하는
  임시보호 일지 앱 다시, 봄입니다.''',
            image: Image.asset('assets/dasibom_ch.png'),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: '추억하기',
            body: '''다시, 봄에서는 임시보호 중인 동물과 추억을
 더욱 특별하게 기록하고, 공유할 수 있습니다.
   임시보호가 종료되어도, 추억을 다시 볼 수 있는 
   숨겨진 선물도 있답니다.''',
            image: Image.asset('assets/dasibom_ch.png'),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: '기록하기',
            body: '''격주마다 다시, 봄 챌린지가 열려요. 
    원하는 테마를 골라 5개 이상의 일기를 쓰면, 챌린지 성공!
            
연속으로 2개의 챌린지에 성공하면
동물 친구와 함께 필름 사진을 찍어드려요!''',
            image: Image.asset('assets/dasibom_ch.png'),
            decoration: getPageDecoration()
        ),
      ],
      done: const Text('done'),
      // Onboarding page가 끝나면 어떻게 할 지
      onDone: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyLoginPage ())
        );
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
    activeSize: Size(22,10),
    activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24)
    )
    ),
      // 애니메이션 효과 적용
      curve: Curves.ease,
    );
  }
  // PageViewModel의 이미지 decoration 인자 값으로 주기 위한 메서드
  PageDecoration getPageDecoration(){
    return PageDecoration(
      // title 스타일
        titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        // 본문 스타일
        bodyTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        imageAlignment: Alignment.bottomRight,
        imagePadding: EdgeInsets.only(top: 40),
        pageColor: Colors.white
    );
  }
}