import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // # 위젯 종류#
      // home: Text("안녕하세요!\n" "반가워요"), // Text 사용
      // home: Icon(Icons.shop), // Icon 사용
      // home: Image.asset('pig.jpg'), // Image 사용
      // home: Center(
      //     child: Container(width: 50,height: 50,color: Colors.red,)), // 위젯의 기준점을 중앙으로 설정

      // home: Scaffold(
      //   appBar: AppBar(), // 상단에 들어갈 위젯
      //   body: Container(), // 중단에 들어갈 위젯
      //   bottomNavigationBar: BottomAppBar(child: Text('게정생성'),), // 하단에 들어갈 위젯

      // // Column으로 위젯 세로로 배치
      // home: Scaffold(
      //   body: Column(
      //     children: [Icon(Icons.star), Icon(Icons.shop),Icon(Icons.share)],
      //   ),
      // ),

      // Row로 위젯 가로로 배치
      // home: Scaffold(
      //   body: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Row, Column 요소를 정렬
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [Icon(Icons.star), Icon(Icons.shop),Icon(Icons.share)],
      //   ),
      // ),

      // Example(1)
      // home: Scaffold(
      //   appBar: AppBar(title: Text('APP')),
      //   body: Text("안녕하세요!"),
      //   bottomNavigationBar: BottomAppBar(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Row, Column 요소를 정렬
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [Icon(Icons.phone), Icon(Icons.message),Icon(Icons.contact_page)],
      // ),
      //     ),
      // )
      // ),

      // 박스 디자인
      // home: Scaffold(
      //   appBar: AppBar(title: Text('App'),),
      //   body: Align( // 박스 위치 정렬
      //     alignment: Alignment.center,
      //     child: Container(
      //       width: double.infinity,height: 250,
      //       // margin: EdgeInsets.all(20), // 박스에 여백주기
      //       padding: EdgeInsets.all(20), // 박스에 여백주기
      //       child: Text('안녕하세요!'),
      //       decoration: BoxDecoration( // 박스에 테두리주기
      //         border: Border.all(color: Colors.blue)
      //       ),
      //     ),
      //   ),
      // ),

      // 글자 디자인
      // home: Scaffold(
      //   appBar: AppBar(title: Text('App'),),
      //   body: SizedBox(
      //     child: Text('안녕하세요!',
      //     style: TextStyle(
      //         color: Colors.blue, //폰트색
      //         fontSize: 30, // 폰트사이즈
      //         letterSpacing: 10, // 폰트자간
      //         fontWeight:FontWeight.w700 // 폰트두께
      //     ),),

      // 버튼 디자인
    //   home: Scaffold(
    //     // AppBar 디자인
    //     appBar: AppBar(
    //       actions:[Icon(Icons.star),Icon(Icons.star)],
    //       title: Text('App'),
    //       leading: Icon(Icons.shop),),
    //     body: SizedBox(
    // child: ElevatedButton(
    //   child: Text('버튼'),
    //   onPressed: (){},
    //   style: ButtonStyle(),
    // ) ,
    //   ),
    //   ),

      // Flexible과 Expanded 사용
      // home: Scaffold(
      //   appBar: AppBar(),
      //   body: Row(
      //     children: [
      //       // Flexible 사용
      //       // Flexible(child: Container(color: Colors.blue),flex: 5),
      //       // Flexible(child: Container(color: Colors.red),flex: 5),
      //       // Flexible(child: Container(color: Colors.green),flex: 5),
      //
      //       // Expanded 사용
      //       Expanded(child: Container(color: Colors.red)),
      //       Container(width: 100,color: Colors.green)
      //     ],
      //   ),
      // ),

      // 커스텀 위젯 만들기
      // home: Scaffold(
      //   appBar: AppBar(),
      //   body: Shop(),
      //   ),

      // ListView() 사용
      home: Scaffold(
        appBar: AppBar(title: Text('App'),),
        body: ListView(
          children: [
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
            Text('A'),
          ],
        ),
      ),

    );
  }
}

// 커스텀 위젯 class
// class Shop extends StatelessWidget {
//   const Shop({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         child: Text('안녕하세요!')
//     );
//   }
// }



