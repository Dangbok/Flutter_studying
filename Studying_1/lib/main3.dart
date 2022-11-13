// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// // 기본 class 생성
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FirstPage(),
//
//       // routes 사용하여 화면 전환
//       // routes: {
//       //   '/first':(context)=>FirstPage(),
//       //   '/second':(context)=>SecondPage(),
//       // },
//
//     );
//   }
// }
//
// // 이름과 나이 프로퍼티를 가지는 Person 클래스 생성
// class Person{
//   String name;
//   int age;
//
//   Person(this.name,this.age);
// }
//
// // 첫 번째 페이지
// class FirstPage extends StatelessWidget {
//   const FirstPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('First')),
//       body: ElevatedButton(
//         child: Text('다음 페이지로'),
//         onPressed: () async {
//
//           // final result =await Navigator.pushNamed(context, '/second'); // routes 사용하여 화면 전환
//
//           final person =Person('홍지원', 24); // Person 클래스에 따른 정보 입력
//           final result= await Navigator.push( // 이전 화면으로 데이터 돌려주기
//             context, // SecondPage로 화면 이동
//             MaterialPageRoute(builder: (context)=>SecondPage(person: person,)),
//           );
//           print(result);
//         },
//       ),
//     );
//   }
// }
//
// // 두 번째 페이지
// class SecondPage extends StatelessWidget {
//   // const SecondPage({Key? key}) : super(key: key);
//   final Person person;
//
//   SecondPage({required this.person}); // @required를 붙이면 필수 입력 인수를 나타냄
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Second'),backgroundColor: Colors.red,),
//       body: ElevatedButton(
//         child: Text('이전 페이지로'),
//         onPressed: (){
//           Navigator.pop(context); // 현재 화면을 종료하고 이전 화면으로 돌아가기
//         },
//       ),
//     );
//   }
// }
//
//
// // # 위젯 종류#
// // home: Text("안녕하세요!\n" "반가워요"), // Text 사용
// // home: Icon(Icons.shop), // Icon 사용
// // home: Image.asset('pig.jpg'), // Image 사용
// // home: Center(
// //     child: Container(width: 50,height: 50,color: Colors.red,)), // 위젯의 기준점을 중앙으로 설정
//
// // home: Scaffold(
// //   appBar: AppBar(), // 상단에 들어갈 위젯
// //   body: Container(), // 중단에 들어갈 위젯
// //   bottomNavigationBar: BottomAppBar(child: Text('게정생성'),), // 하단에 들어갈 위젯
//
// // // Column으로 위젯 세로로 배치
// // home: Scaffold(
// //   body: Column(
// //     children: [Icon(Icons.star), Icon(Icons.shop),Icon(Icons.share)],
// //   ),
// // ),
//
// // Row로 위젯 가로로 배치
// // home: Scaffold(
// //   body: Row(
// //     mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Row, Column 요소를 정렬
// //     crossAxisAlignment: CrossAxisAlignment.end,
// //     children: [Icon(Icons.star), Icon(Icons.shop),Icon(Icons.share)],
// //   ),
// // ),
//
// // Example(1)
// // home: Scaffold(
// //   appBar: AppBar(title: Text('APP')),
// //   body: Text("안녕하세요!"),
// //   bottomNavigationBar: BottomAppBar(
// //     child: Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Row, Column 요소를 정렬
// //         crossAxisAlignment: CrossAxisAlignment.end,
// //         children: [Icon(Icons.phone), Icon(Icons.message),Icon(Icons.contact_page)],
// // ),
// //     ),
// // )
// // ),
//
// // 박스 디자인
// // home: Scaffold(
// //   appBar: AppBar(title: Text('App'),),
// //   body: Align( // 박스 위치 정렬
// //     alignment: Alignment.center,
// //     child: Container(
// //       width: double.infinity,height: 250,
// //       // margin: EdgeInsets.all(20), // 박스에 여백주기
// //       padding: EdgeInsets.all(20), // 박스에 여백주기
// //       child: Text('안녕하세요!'),
// //       decoration: BoxDecoration( // 박스에 테두리주기
// //         border: Border.all(color: Colors.blue)
// //       ),
// //     ),
// //   ),
// // ),
//
// // 글자 디자인
// // home: Scaffold(
// //   appBar: AppBar(title: Text('App'),),
// //   body: SizedBox(
// //     child: Text('안녕하세요!',
// //     style: TextStyle(
// //         color: Colors.blue, //폰트색
// //         fontSize: 30, // 폰트사이즈
// //         letterSpacing: 10, // 폰트자간
// //         fontWeight:FontWeight.w700 // 폰트두께
// //     ),),
//
// // 버튼 디자인
// //   home: Scaffold(
// //     // AppBar 디자인
// //     appBar: AppBar(
// //       actions:[Icon(Icons.star),Icon(Icons.star)],
// //       title: Text('App'),
// //       leading: Icon(Icons.shop),),
// //     body: SizedBox(
// // child: ElevatedButton(
// //   child: Text('버튼'),
// //   onPressed: (){},
// //   style: ButtonStyle(),
// // ) ,
// //   ),
// //   ),
//
// // Flexible과 Expanded 사용
// // home: Scaffold(
// //   appBar: AppBar(),
// //   body: Row(
// //     children: [
// //       // Flexible 사용
// //       // Flexible(child: Container(color: Colors.blue),flex: 5),
// //       // Flexible(child: Container(color: Colors.red),flex: 5),
// //       // Flexible(child: Container(color: Colors.green),flex: 5),
// //
// //       // Expanded 사용
// //       Expanded(child: Container(color: Colors.red)),
// //       Container(width: 100,color: Colors.green)
// //     ],
// //   ),
// // ),
//
// // 커스텀 위젯 만들기
// // home: Scaffold(
// //   appBar: AppBar(),
// //   body: Shop(),
// //   ),
//
// // ListView(), ListTile() 사용
// // home: Scaffold(
// //   appBar: AppBar(
// //     title: Text('App'),
// //   ),
// //   body: ListView(
// //     scrollDirection: Axis.vertical,
// //     children: [
// //       ListTile(
// //         leading: Icon(Icons.home),
// //         title: Text('Home'),
// //         trailing: Icon(Icons.navigate_next),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         leading: Icon(Icons.event),
// //         title: Text('Event'),
// //         trailing: Icon(Icons.navigate_next),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         leading: Icon(Icons.camera),
// //         title: Text('Camera'),
// //         trailing: Icon(Icons.navigate_next),
// //         onTap: () {},
// //       ),
// //     ],
// //   ),
// // ),
//
// // Stack() 사용
// // home: Scaffold(
// //   appBar: AppBar(title: Text('앱'),),
// //   body: Stack(
// //     children: [
// //       Container(
// //         color: Colors.red,
// //         width:100,
// //         height: 100,
// //         padding: const EdgeInsets.all(8),
// //         margin: const EdgeInsets.all(8),
// //       ),
// //       Container(
// //         color: Colors.green,
// //         width:80,
// //         height: 80,
// //         padding: const EdgeInsets.all(8),
// //         margin: const EdgeInsets.all(8),
// //       ),
// //       Container(
// //         color: Colors.blue,
// //         width:60,
// //         height: 60,
// //         padding: const EdgeInsets.all(8),
// //         margin: const EdgeInsets.all(8),
// //       ),
// //     ],
// // ),
// // ),
//
// // SingleChildScrollView() 사용
// // home: Scaffold(
// //   appBar: AppBar(title: Text('App'),),
// //   body:SingleChildScrollView(
// //     child: ListBody(
// //     final items=List.generate(100,(i)=>i).toList();
// //       children:items.map((i)=>Text('$1')).toList(),
// //     ),
// //   ),
// // ),
//
// // GridView() 사용
// //   home: Scaffold(
// //       appBar: AppBar(
// //           title: Text('App'),),
// //           body:GridView.count(
// //             crossAxisCount: 2, // 열 수 지정
// //             children: [
// //               Container(
// //                 color: Colors.red,
// //                 width: 100,
// //                 height: 100,
// //                 padding: const EdgeInsets.all(8),
// //                 margin: const EdgeInsets.all(8),
// //               ),
// //               Container(
// //                 color: Colors.green,
// //                 width: 100,
// //                 height: 100,
// //                 padding: const EdgeInsets.all(8),
// //                 margin: const EdgeInsets.all(8),
// //               ),
// //               Container(
// //                 color: Colors.blue,
// //                 width: 100,
// //                 height: 100,
// //                 padding: const EdgeInsets.all(8),
// //                 margin: const EdgeInsets.all(8),
// //               ),
// //             ],
// //           )
// //   ),
//
// // PageView() 사용
// // home: Scaffold(
// //   appBar: AppBar(title: Text('App'),),
// //   body: PageView(
// //     children: [
// //       Container(
// //         color: Colors.red,
// //       ),
// //       Container(
// //         color: Colors.green,
// //       ),
// //       Container(
// //         color: Colors.blue,
// //       ),
// //     ],),
// // ),
//
// // AppBar, TabBar, Tab, TabBarView() 사용
// // -> MetrialApp()으로 감싸고 home을 DefaultTabController()- length 사용 (구글링)
// // home: DefaultTabController(
// //   length:3,
// //   child: Scaffold(
// //     appBar: AppBar(
// //       title: Text('Tab'),
// //       bottom: TabBar(
// //         tabs: [
// //           Tab(icon: Icon(Icons.tag_faces)),
// //           Tab(text: '메뉴2'),
// //           Tab(icon: Icon(Icons.info),text: '메뉴3'),
// //         ],
// //       ),
// //     ),
// //     body: TabBarView(
// //       children: [
// //         Container(color: Colors.yellow,),
// //         Container(color: Colors.orange,),
// //         Container(color: Colors.red,),
// //       ],
// //     ),
// //   ),
// // ),
//
// // Card() 사용
// // home: Scaffold(
// //   appBar: AppBar(
// //     title: Text('App'),),
// //   body: Center(
// //     child: Card(
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(16)
// //       ),
// //       elevation: 4,
// //       child: Container(
// //         width: 200,
// //         height: 200,
// //       ),
// //     ),
// //   ),
// // ),
//
// // CircleAvatar() 사용
// // home: Scaffold(
// //   appBar: AppBar(
// //     title: Text('App'),),
// //   body: Center(
// //     child: CircleAvatar(
// //       child: Icon(Icons.person),
// //     ),
// //   ),
// // ),
//
// // TextField() 사용
// // home: Scaffold(
// //   appBar: AppBar(title: Text('App')),
// //   body: Center(
// //     child: TextField(
// //       decoration: InputDecoration(
// //         border: OutlineInputBorder(), // 외곽선
// //         labelText: '여기에 입력하세요'
// //       ),
// //     ),
// //   ),
// // ),
//
//
// // 커스텀 위젯 class
// // class Shop extends StatelessWidget {
// //   const Shop({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //         child: Text('안녕하세요!')
// //     );
// //   }
// // }
