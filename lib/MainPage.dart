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
  final viewModel = MainViewModel(KakaoLogin());

  var _index = 0; // 페이지 인덱스 0,1,2,3

  var _pages = [
    // Page1,2,3,4 클래스와 연동하여 변수 선언(페이지를 _pages 리스트 변수의 값으로 정의)
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      // 상단 앱 바
      appBar: AppBar(
        backgroundColor: Color(0xffFFF1AA), // 배경색을 흰색으로
        title: Image.asset('assets/logo.png', width: 45, height: 45),
        actions: <Widget>[
          // actions 프로퍼티에는 어떠한 위젯도 리스트로 배치 가능
          IconButton(
            onPressed: () {},
            icon: Icon((Icons.chat)),
            color: Colors.black, // 앱의 전체 테마를 수정했다면 작성하지 않아도 됨
          ),
          IconButton(
            onPressed: () {},
            icon: Icon((Icons.notifications)),
            color: Colors.black, // 앱의 전체 테마를 수정했다면 작성하지 않아도 됨
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon((Icons.menu)),
            color: Colors.black, // 앱의 전체 테마를 수정했다면 작성하지 않아도 됨
          ),
          // 로그아웃 버튼
          // ElevatedButton(
          //     // onPressed: () async {
          //     //   await viewModel.logout();
          //     //   setState(() {});
          //     //   // 버튼 클릭시 로그인 페이지로 이동
          //     //   Navigator.pushNamedAndRemoveUntil(
          //     //       context, '/login', (route) => false);
          //     // },
          //     // child: const Text('Logout'))
        ],
        // centerTitle: true, // 제목을 가운데로
      ),
      // 옵션 바
      endDrawer: Drawer(
        elevation: 10,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_index], // index에 따라 페이지 바뀜
      // 글쓰기 플로팅 위젯
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
          backgroundColor: Color(0xff8FDBA2)),
      // 하단 내비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _index = index; // 선택된 탭의 인덱스로 _index를 변경
          });
        },
        currentIndex: _index,
        // 선택된 인덱스
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // 하단 탭 아이템리스트 선언
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '일기쓰기',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: '임시',
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: '나의 봄',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}

// 홈 클래스-> Scaffold의 body 프로퍼티에 코드 연동
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

// 둘러보기 클래스
class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 100,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.grey,
                );
              }),
        ],
      ),
    );
  }
}

// 마켓 클래스
class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '마켓',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}

// 내 정보 클래스
class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> with TickerProviderStateMixin {
  late TabController tabController; // Tab 변수 선언

  // Tab 변수 초기화
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              indicatorWeight: 1,
              tabs: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('프로필'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('히스토리'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('내활동'),
                ),
              ]),
          Expanded(
            // 내 정보 내의 탭 컨트롤러 지정
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Page11(),
                Page22(),
                Page33(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 내 정보- 프로필 탭
class Page11 extends StatelessWidget {
  const Page11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          _information(),
          _menu(),
          _tabView()
        ],
      ),
    );
  }

  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }

  // 프로필 내정보 위젯
  Widget _information() {
    final viewModel = MainViewModel(KakaoLogin());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    viewModel.user?.kakaoAccount?.profile?.profileImageUrl ??
                        ''),
                // backgroundImage: AssetImage('assets/img.jpg'),
              ),
              // 유저 프로필사진 가져오기
              // Image.network(
              //   viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? '',
              // ),
              const SizedBox(width: 30),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _statisticsOne('공개일기', 10)),
                    Expanded(child: _statisticsOne('숨긴일기', 1)),
                    Expanded(child: _statisticsOne('팔로워', 100)),
                    Expanded(child: _statisticsOne('팔로잉', 100)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Jiwon',
            style: TextStyle(fontSize: 15, color: Colors.black),
          )
        ],
      ),
    );
  }

  // 프로필 Edit profile 위젯
  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xffdedede),
                ),
              ),
              child: const TextButton(
                onPressed: null,
                child: Text('Edit profile'),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 프로필 게시물 GridView 위젯
  Widget _tabView() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
          );
        });
  }
}

// 내 정보- 히스토리 탭
class Page22 extends StatelessWidget {
  const Page22({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('history');
  }
}

// 내 정보- 내활동 탭
class Page33 extends StatelessWidget {
  const Page33({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('activity');
  }
}
