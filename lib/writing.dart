import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_flutter2/MainPage.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Writing extends StatefulWidget {
  const Writing({Key? key}) : super(key: key);

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  // 이미지 받아오기
  XFile? _pickedFile; // 이미지를 담을 변수 선언
  List<XFile?> _pickedImages = []; // 이미지 여러개 담을 변수 선언
  final ImagePicker imagePicker = ImagePicker(); // ImagePicker 초기화

  // 이미지 여러개 pick
  Future<void> _pickImg() async {
    final List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImages = images;
      });
    }
  }

  bool isDefault = false;

  // Textformfield 값 받아오기
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  final TextEditingController _bodyController =
  TextEditingController(); // 본문 저장 변수

  late bool validationResult;
  String _body = ''; // 본문

  // 동물 친구 콤보박스
  final _write = ['카야', '소미'];
  var _selectedWrite = '카야';

  // 카테고리 콤보박스
  final _category = ['일기쓰기', '챌린지 등록하기'];
  var _selectedcategory = '일기쓰기';

  // 주제 다중 선택
  List<String> tags = [];
  List<String> options = [
    '산책', '간식', '장난감', '목욕',
    '소풍', '드라이브', '미용실',
    '병원', '잠',
  ];

  // 나만보기 토글
  bool status = false;

  @override
  void initState() {
    validationResult = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPadMode = MediaQuery
        .of(context)
        .size
        .width > 700;

    // 사진 Gridview
    List<Widget> _boxContents = [
      IconButton(
          onPressed: () {
            _pickImg();
          },
          icon: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
              child: Icon(
                CupertinoIcons.camera,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ))),
      Container(),
      Container(),
      _pickedImages.length <= 4
          ? Container()
          : FittedBox(
          child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle),
              child: Text(
                '+${(_pickedImages.length - 4).toString()}',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w800),
              ))),
    ];

    return SafeArea(
      child: Scaffold(
        body: Form(
          // form으로 input 데이터 저장
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                // 글 쓸 동물 친구 등록
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 150),
                  child: DropdownButtonFormField(
                    value: _selectedWrite,
                    items: _write.map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedWrite = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: const Text(
                    '카테고리',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 카테고리 등록
                Padding(
                  padding: const EdgeInsets.only(right: 130, left: 20, top: 5),
                  child: DropdownButtonFormField(
                    value: _selectedcategory,
                    items: _category.map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedcategory = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: const Text(
                    '사진',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 사진 등록
                GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: isPadMode ? 1 : 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: List.generate(
                      4,
                          (index) =>
                          DottedBorder(
                              child: Container(
                                child: Center(child: _boxContents[index]),
                                decoration: index <= _pickedImages.length - 1
                                    ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(_pickedImages[index]!.path))))
                                    : null,
                              ),
                              color: Colors.grey,
                              dashPattern: [8, 3],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10))).toList(),
                ),
                Container(
                  width: 340,
                  child: const Text(
                    '본문',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 본문 등록
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        hintText: '카야와 3일째 기록!'),
                    onSaved: (value) {
                      setState(() {
                        _body = value as String;
                      });
                    },
                    controller: _bodyController,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: const Text(
                    '주제',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 주제 해시태그 등록
                ChipsChoice<String>.multiple(
                    value: tags,
                    onChanged: (val) => setState(() => tags = val),
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: options,
                      value: (i, v) => v,
                      label: (i, v) => v,
                      tooltip: (i, v) => v,
                    ),
                    choiceCheckmark: false,
                    choiceStyle: C2ChipStyle.outlined(),
                  ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: const Text(
                    '나만 보기 설정',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 나만 보기 설정
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterSwitch(
                        activeColor: Colors.green,
                        width: 60,
                        height: 30,
                        valueFontSize: 10,
                        toggleSize: 20,
                        value: status,
                        borderRadius: 30,
                        padding: 8,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                      const Text(
                        '* 일기를 나만 열람할 수 있어요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // 일기 등록하기
                SizedBox(
                  height: 60,
                  width: 350,
                  child: Container(
                    height: 30,
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFFFED8E)),
                      ),
                      onPressed: () {
                        setState(
                              () async {
                            validationResult =
                                formKey.currentState?.validate() ?? false;
                            formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                  Text('$_selectedcategory/$_body')),
                            );

                            // Writing(formData);

                            // 일기쓰기 완료 팝업 메시지
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('완료'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text('일기가 등록되었습니다:)'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('확인'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(_createRoute());
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        );
                      },
                      child: const Text(
                        "일기 등록하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 페이지 전환 애니메이션
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 10.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // 아래의 해당 함수(카메라, 갤러리, 기본이미지)를 버튼과 연결
  _showBottomSheet() {
    return showModalBottomSheet(
      context: this.context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _getCameraImage(),
              child: const Text('카메라'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _getPhotoLibraryImage(),
              child: const Text('갤러리'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

// 카메라로 이동
  _getCameraImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        isDefault = false;
        _pickedImages = pickedFile as List<XFile?>;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

// 갤러리로 이동
  _getPhotoLibraryImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        isDefault = false;
        _pickedImages = pickedFile as List<XFile?>;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}

