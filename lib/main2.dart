import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// enum Gender {MAN, WOMAN} // Radio 그룹되는 항목 열거형으로 정의

class _MyHomePageState extends State<MyHomePage> {
  // var _isChecked = false; // CheckBox
  // Gender _gender =Gender.MAN; // Radio
  // final _valueList=['첫 번째','두 번째','세 번째']; // DropDownButton
  // var _selectedValue='첫 번째';
  // DateTime _selectedTime; // DataPicker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // # 위젯 종류#

      appBar: AppBar(
        title: Text('App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CheckBox와 Switch() 사용 -> 변수 선언
              // Checkbox(
              //   value: _isChecked,
              //   onChanged: (value) {
              //     setState(() {
              //       _isChecked = value!;
              //     });
              //   },
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              // Switch(
              //   value: _isChecked,
              //   onChanged: (value) {
              //     setState(() {
              //       _isChecked = value;
              //     });
              //   },
              // ),

              // Radio와 RadioListTile() 사용
              // ListTile(
              //   title: Text('남자'),
              //   leading: Radio(
              //     value: Gender.MAN,
              //     groupValue: _gender,
              //     onChanged: (value){
              //       setState(() {
              //         _gender=value!;
              //       });
              //     },
              //   ),
              // ),
              // ListTile(
              //   title: Text('여자'),
              //   leading: Radio(
              //     value: Gender.WOMAN,
              //     groupValue: _gender,
              //     onChanged: (value){
              //       setState(() {
              //         _gender=value!;
              //       });
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              // RadioListTile(
              //     title: Text('남자'),
              //     value: Gender.MAN,
              //     groupValue: _gender,
              //     onChanged: (value){
              //       setState(() {
              //         _gender=value!;
              //       });
              //     },
              // ),
              // RadioListTile(
              //   title: Text('여자'),
              //   value: Gender.WOMAN,
              //   groupValue: _gender,
              //   onChanged: (value){
              //     setState(() {
              //       _gender=value!;
              //     });
              //   },
              // ),

              // DropDownButton() 사용
              // DropdownButton(
              //     value: _selectedValue,
              //     items: _valueList.map(
              //         (value){
              //           return DropdownMenuItem(
              //               value: value,
              //               child: Text(value),
              //           );
              //         },
              //     ).toList(),
              //     onChanged: (value){
              //       setState(() {
              //         _selectedValue=value!;
              //       });
              //     },
              // ),

              //  AlertDialog() 사용
              //     showDialog(
              //     context: context,
              //     barrierDismissible: false,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: Text('제목'),
              //         content: SingleChildScrollView(
              //           child: ListBody(
              //             children: [
              //               Text('Alert Dialog입니다.'),
              //               Text('OK를 눌러 닫습니다.'),
              //             ],
              //           ),
              //         ),
              //         actions: [
              //           TextButton(
              //             child: Text('OK'),
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //           ),
              //           TextButton(
              //             child: Text('Cancel'),
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //           ),
              //         ],
              //       );
              //     };
              // );

              // DataPicker() 사용
              // ElevatedButton(
              //   onPressed: () {
              //     Future<DateTime> selectedDate = showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       // 시작일
              //       firstDate: DateTime(2022),
              //       // 마지막일
              //       lastDate: DateTime(2030),
              //       builder: (BuildContext context, Widget child) {
              //         return Theme(
              //           data: ThemeData.dark(),
              //           child: child,
              //         );
              //       },
              //     );
              //
              //     slectedDate.then((dateTime) {
              //       setState(() {
              //         _selectedTime = dateTime;
              //       });
              //     });
              //   },
              //   child: Text('Data Picker'),
              // ),
              // Text('$_selectedTime'),

              // GestureDetector와 InkWell() 사용
              GestureDetector(
                onTap: () {
                  print('GestureDetector 클릭!!');
                },
                child: Text('클릭 Me!!'),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  print('InkWell 클릭!!');
                },
                child: Text('클릭 Me!!'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
