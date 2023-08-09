import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

// http
import 'package:http/http.dart' as http;

// 스토어 생성, state, state handler 함수 등록
class UserStore extends ChangeNotifier {
  var name = '';
  var exampleData = [];

  // 동물 친구
  var animalName = '';

  setName(value) {
    animalName = value;
    notifyListeners(); // 값 변경후 재렌더링을 위해 사용
  }

// get 요청후 데이터를 state에 저장하는 경우, 필요한 곳에서 이 함수 실행
// getData() async {
//   var result = await http.get(Uri.parse(''));
//   var jsonData = jsonDecode(result.body);
//   exampleData = jsonData;
//   notifyListeners();
// }
}
