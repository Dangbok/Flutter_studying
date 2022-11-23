import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:login_flutter2/Kakao_login.dart';
import 'package:login_flutter2/MyLoginPage.dart';
import 'package:login_flutter2/main_view_model.dart';

// Page1의 _buildMiddle() 메서드에 들어갈 사진 url
final dummyItems = [
  'https://cdn.pixabay.com/photo/2016/11/22/23/44/porsche-1851246_960_720.jpg',
  'https://cdn.pixabay.com/photo/2016/11/29/01/22/automotive-1866521_960_720.jpg',
  'https://cdn.pixabay.com/photo/2016/03/11/02/08/speedometer-1249610_960_720.jpg',
];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 로그인 생성자
  final viewModel=MainViewModel(KakaoLogin());

  var _index = 0; // 페이지 인덱스 0,1,2

  var _pages = [
    // Page1,2,3 클래스와 연동하여 변수 선언(페이지를 _pages 리스트 변수의 값으로 정의)
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색을 흰색으로
        title: Text(
          '다시,봄',
          style: TextStyle(color: Colors.black), // 글자색을 검은색으로
        ),
        actions: <Widget>[
          // actions 프로퍼티에는 어떠한 위젯도 리스트로 배치 가능
          IconButton(
            onPressed: () {},
            icon: Icon((Icons.add)),
            color: Colors.black, // 앱의 전체 테마를 수정했다면 작성하지 않아도 됨
          ),
          // 로그아웃 버튼
          ElevatedButton(
              onPressed: () async {
                await viewModel.logout();
                setState(() {});
                // 버튼 클릭시 로그인 페이지로 이동
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              child: const Text('Logout'))
        ],
        centerTitle: true, // 제목을 가운데로
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index; // 선택된 탭의 인덱스로 _index를 변경
          });
        },
        currentIndex: _index, // 선택된 인덱스
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // 하단 탭 아이템리스트 선언
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '이용서비스',
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: '내 정보',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}

// 홈페이지 클래스-> Scaffold의 body 프로퍼티에 코드 연동
class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Column을 ListView로 변경하면 상하 스크롤이 생김
      children: <Widget>[
        _buildTop(),
        _buildMiddle(),
        _buildBottom(),
      ],
    );
  }

  // 상단
  Widget _buildTop() {
    return Padding(
      // 전체 여백 주기
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                // 위젯 클릭 시 물결 효과(클릭 가능하게 함)
                onTap: () {
                  print('클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('택시'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('클릭');
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('블랙'),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('바이크'),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('대리'),
                ],
              ),
            ],
          ), // 이것을 복사해서
          SizedBox(
            // 20만큼의 여백을 표현-> 단독으로 사용하면단순히 여백을 주는 용도로 자주 사용
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('택시'),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('블랙'),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.local_taxi,
                    size: 40,
                  ),
                  Text('바이크'),
                ],
              ),

              // Opacity로 감싸면 위젯을 숨길 수 있다.
              Opacity(
                opacity: 0, // 값이 0이면 완전 투명, 1이면 완전 불투명
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.local_taxi,
                      size: 40,
                    ),
                    Text('대리'),
                  ],
                ),
              ),
            ],
          ), // 여기에 붙여넣기
        ],
      ),
    );
  }

  // ??중단??
  Widget _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
      ),
      items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect(
                // ClipRRect는 child를 둥근 사각형으로 자르는 위젯
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

// 하단
  Widget _buildBottom() {
    final items = List.generate(100, (i) {
      // 0부터 9까지의 수를 생성하여 두 번째 인수의 함수에 i 매개변수로 전달함
      var num = i + 1;
      return ListTile(
        // i 값을 전달받아 ListTile 위젯 형태로 변환하여 그것들의 리스트가 반환됨
        leading: Icon(Icons.notifications_none),
        title: Text('[이벤트] 이것은 $num번째 공지사항입니다.'),
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(), // 이 리스트의 스크롤 동작 금지
      shrinkWrap: true, // 이 리스트의 다른 스크롤 객체 안에 있다면 true로 설정해야 함
      children: items,
    );
  }
}

// 이용서비스 클래스
class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '이용서비스',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}

// 내 정보 클래스
class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '내 정보',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}