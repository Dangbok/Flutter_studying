import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Seeing extends StatefulWidget {
  // 서버에서 정보 받아올 때 변수 선언
  // final String userImage;
  // final String userName;
  // final List<String> images;
  // final int countLikes; // 좋아요 수
  // final int countComment; //댓글 수
  // const Feed(
  //     {super.key,
  //       required this.userImage,
  //       required this.userName,
  //       required this.images,
  //       required this.countLikes,
  //       required this.countComment});

  const Seeing({Key? key}) : super(key: key);

  @override
  State<Seeing> createState() => _SeeingState();
}

class _SeeingState extends State<Seeing> {
  // 일기 이미지 인덱스
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      key: scaffoldKey,
      child: Scaffold(
        // 상단 앱 바
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/ic_barlogo.png', width: 100, height: 100),
          automaticallyImplyLeading: false, // appbar 뒤로가기 버튼 숨김
          actions: <Widget>[
            // actions 프로퍼티에는 어떠한 위젯도 리스트로 배치 가능
            IconButton(
              // 채팅 버튼
              onPressed: () {},
              icon: Image.asset('assets/ic_chat.png'),
              color: Colors.black,
            ),
            IconButton(
              // 알림 버튼
              onPressed: () {},
              icon: Image.asset('assets/ic_alarm.png'),
              color: Colors.black,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        // 하단 내비게이션 바
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              // 선택된 탭의 인덱스로 _index를 변경
            });
          },
          // 선택된 인덱스
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // 하단 탭 아이템리스트 선언
              label: '홈',
              icon: Image.asset('assets/ic_bottom1.png'),
            ),
            BottomNavigationBarItem(
              label: '일기쓰기',
              icon: Image.asset('assets/ic_bottom2.png'),
            ),
            BottomNavigationBarItem(
              label: '임시',
              icon: Image.asset('assets/ic_bottom3.png'),
            ),
            BottomNavigationBarItem(
              label: '나의 봄',
              icon: Image.asset('assets/ic_bottom4.png'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _header(), // 사용자 정보
              _images(), // 일기 사진
              _comment(), // 일기 내용
              _options(), // 댓글, 쓰다듬기, 공유하기
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //두개의 위젯을 서로 붙이려면 Row 내부에서 Row로 묶으면 됨.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 프로필 사진
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/user1.png'),
              ),
              // child: ImageAvatar(
              //   url: widget.userUrl,
              //   type: AvatarType.BASIC,
              // ),
            ),
            // 프로필 이름
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                // widget.userName,
                '카야',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        // 더보기 버튼
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            child: Image.asset('assets/ic_more.png'),
          ),
        ),
      ],
    );
  }

  Widget _images() {
    return CarouselSlider.builder(
        //이미지 갯수
        itemCount: 1,
        //   itemCount: widget.images.length,
        //이미지 빌더
        itemBuilder: (context, index, realIndex) {
          return Container(
            color: Colors.black,
            width: 500,
            height: 500,
            child: Image.asset(
              'assets/dog.jpg',
              fit: BoxFit.cover,
            ),
            // child: CachedNetworkImage(
            //   //인덱스에 해당하는 이미지 로드
            //   imageUrl: widget.images[index],
            //   fit: BoxFit.cover,
            // ),
          );
        },
        // carousel_slider 옵션 정의
        options: CarouselOptions(
          //무한대로 스크롤 되는 지
          enableInfiniteScroll: true,
          //가로세로 비율 정의
          aspectRatio: 1,
          //Fraction 비율 정의
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              //인덱스 갱신
              _current = index;
            });
          },
        )
    );
  }

  Widget _comment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 쓰다듬기 count
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '123번 쓰다듬받았어요!',
              // '좋아요 ${widget.countLikes}개',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // 본문 내용
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ExpandableText(
              // 피드 내용
              '카야랑 오늘은 한강을 따라 산책을 갔다.\n흙냄새가 좋은지..마구 달리던 카야\n너무 귀여웠다.\n오늘의 산책 완료!',
              expandText: '더보기', //더보기 글자
              linkColor: Colors.grey, //더보기 글자 색 지정
              prefixText: '글린다', // 작성자의 이름
              // 작성자의 이름 스타일
              prefixStyle:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          // 챌린지 주제
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              '[챌린지] 날도 좋은데, 기분 좋은 산책 일기',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          //댓글 모두 보기 부분
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                '댓글 10개 모두 보기',
                // '댓글 ${widget.countComment}개 모두 보기',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          // 댓글 달기 영역
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/user2.png'),
                ),
                // child: ImageAvatar(
                //   url:
                //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnnnObTCNg1QJoEd9Krwl3kSUnPYTZrxb5Ig&usqp=CAU',
                //   type: AvatarType.BASIC,
                // ),
              ),
              GestureDetector(
                // onTap: showCommentModal,
                child: const Text(
                  '댓글 달기...',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // 댓글
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 10),
              child: GestureDetector(
                child: Image.asset('assets/ic_comment.png'),
              ),
            ),
            const Text(
              '(10)',
            ),
            // 쓰다듬기
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 10),
              child: GestureDetector(
                child: Image.asset('assets/ic_good.png'),
              ),
            ),
            const Text(
              '(123)',
            ),
          ],
        ),
        Row(
          children: [
            // 공유하기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                child: Image.asset('assets/ic_share.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
