import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// 비만도 계산기
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 웹에서의 제목표시줄 느낌
      title: '플러터 데모',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

// 첫 번째 페이지
class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formkey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키

  final _heightController =
  TextEditingController(); // 키와 몸무게의 값을 가져오는 각 컨트롤러 인스턴스 준비
  final _weightController = TextEditingController();

  // 다 사용한 컨트롤러의 인스턴스는 반드시 화면이 종료될 때 dispose() 메서드로 해제해야 함
  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  // 외곽선이 있고 힌트로 '키'를 표시
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                controller: _heightController, // 컨트롤러 연결
                keyboardType: TextInputType.number, // 입력 타입을 제한
                validator: (value) {
                  // 입력값을 검증하고 에러 메시지를 반환하도록 작성
                  if (value!.trim().isEmpty) {
                    // 입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 표시
                    return '키를 입력하세요';
                  }
                  return null; // null을 반환하면 에러가 없는 것임
                }, // 숫자만 입력할 수 있음
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // 폼에 입력된 값 검증
                    if (_formkey.currentState!.validate()) {
                      // 키와 몸무게 값이 검증되었다면 화면 이동
                      // 검증시 처리
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BmiResult(
                                    double.parse(_heightController.text.trim()),
                                    double.parse(
                                        _weightController.text.trim()))),
                      );
                    }
                  },
                  child: Text('결과'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 두 번째 페이지
class BmiResult extends StatelessWidget {
  final double height; // 키
  final double weight; // 몸무게

  BmiResult(this.height, this.weight); // 키와 몸무게를 받는 생성자

  @override
  Widget build(BuildContext context) {
    // bmi 값 계산 변수
    final bmi = weight / ((height / 100) * (height / 100));
    print('bmi: $bmi');

    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _calBmi(bmi), // 계산 결과에 따른 결과 문자열
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            _buildIcon(bmi), // 계산 결과에 따른 아이콘
          ],
        ),
      ),
    );
  }

  // BMI 값에 따라 결과 표시 메서드
  String _calBmi(double bmi) {
    var result = '저체중';
    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  // BMI 값에 따라 아이콘 표시 메서드
  Widget _buildIcon(double bmi) {
    if (bmi >= 23) {
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    }
    else if (bmi >= 18.5) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,);
    }
    else {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.orange,
        size: 100,);
    }
  }
}

// TextField() 사용
// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({Key? key}) : super(key: key);
//
//   @override
//   State<MyCustomForm> createState() => _MyCustomFormState();
// }
//
// class _MyCustomFormState extends State<MyCustomForm> {
//   final myController = TextEditingController(); // TextField의 현잿값을 얻는 데 필요
//   final _formkey = GlobalKey<FormState>(); // Form 위젯에 유니크한 키값을 부여하고 검증시 사용
//
//   // ?
//   @override
//   void initState() {
//     super.initState();
//
//     // addListener로 상태를 모니터링할 수 있음
//     // TextField 위젯의 값이 변경될 때마다 무언가를 수행하고 싶다면 addListener() 메서드 사용
//     myController.addListener(_printLatestValue);
//   }
//
//   // 컨트롤러는 화면이 종료될 때 dispose() 메서드로 반드시 해제해야 함
//   @override
//   void dispose() {
//     // 화면이 종료될 때는 반드시 위젯 트리에서 컨트롤러를 해제해야 함
//     myController.dispose();
//     super.dispose();
//   }
//
//   _printLatestValue() {
//     // 컨트롤러의 text 프로퍼티로 연결된 TextField에 입력된 값을 얻음
//     print('두 번째 text field: ${myController.text}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Form 위젯에 _formkey를 지정
//     return Form(
//       key: _formkey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextField(
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '글자를 입력하세요';
//               }
//               return null;
//             },
//           ),
//           Padding(padding: const EdgeInsets.symmetric(vertical: 16),
//             child: ElevatedButton(
//               onPressed: () {
//                 // 폼을 검증하여 통과하면 true, 실패하면 false 리턴
//                 if (_formkey.currentState!.validate()) {
//                   // 검증이 통과하면 스낵바 표시
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       snackBar(content: Text('검증 완료')));
//                 }
//               },
//               child: Text('검증'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Text Input 연습'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: <Widget>[
//           TextField(
//             onChanged: (text){ // 텍스트 변경 감지 이벤트
//               print('첫 번째 text field: $text');
//             },
//           ),
//           TextField(
//             controller: myController, // 컨트롤러 지정
//           )
//         ],
//       ),
//     ),
//   );
// }
// }
