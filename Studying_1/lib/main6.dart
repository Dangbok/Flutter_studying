// import 'package:flutter/material.dart';
// import 'dart:async';
//
// void main() => runApp(MyApp());
//
// // 스탑워치
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'StopWatch',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StopWatchPage(),
//     );
//   }
// }
//
// class StopWatchPage extends StatefulWidget {
//   const StopWatchPage({Key? key}) : super(key: key);
//
//   @override
//   State<StopWatchPage> createState() => _StopWatchPageState();
// }
//
// class _StopWatchPageState extends State<StopWatchPage> {
//   late Timer _timer; // 타이머
//
//   var _time=0; // 0.01초마다 1씩 증가시킬 정수형 변수
//   var _isRunning =false; // 현재 시작 상태를 나타낼 불리언 변수
//
//   List<String> _lapTimes=[]; // 랩타임에 표시할 시간을 저장할 리스트
//
//   @override
//   void dispose(){
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('StopWatch'),
//       ),
//       body: _buildBody(),
//       bottomNavigationBar: BottomAppBar( // 하단에 배치하는 AppBar
//         child: Container(
//           height: 50,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton( // 시작 버튼이 위치함
//         onPressed: ()=>setState(() {
//           _clickButton();
//         }),
//         child: Icon(Icons.play_arrow),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
//
//   // 내용 부분
//   Widget _buildBody(){
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 30),
//         child: Stack(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Row( // 시간을 표시하는 영역
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     Text('0',
//                       style:TextStyle(fontSize: 50),
//                     ),
//                     Text('00'),
//                   ],
//                 ),
//                 Container( // 랩타임을 표시하는 영역
//                   width: 100,
//                   height: 200,
//                   child: ListView(
//                     children: <Widget>[
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Positioned(
//               left: 10,
//               bottom: 10,
//               child: FloatingActionButton( // 왼쪽 아래에 위치한 초기화 버튼
//                 backgroundColor: Colors.deepOrange,
//                 onPressed: (){},
//                 child: Icon(Icons.rotate_left),
//               ),
//             ),
//             Positioned(
//               right: 10,
//               bottom: 10,
//               child: ElevatedButton( // 오른쪽 아래에 위치한 랩타임 버튼
//                 onPressed: (){},
//                 child: Text('랩타임'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//
// // 시작 또는 일시정지 버튼 클릭
//   void _clickButton(){
//     _isRunning=!_isRunning;
//
//     if(_isRunning){
//       _start();
//     }
//     else{
//       _pause();
//     }
//   }
//
// }
