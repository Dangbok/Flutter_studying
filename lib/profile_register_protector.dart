import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_flutter2/profile_register_animal.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterProfileProtector extends StatefulWidget {
  const RegisterProfileProtector({Key? key}) : super(key: key);

  @override
  State<RegisterProfileProtector> createState() =>
      _RegisterProfileProtectorState();
}

class _RegisterProfileProtectorState extends State<RegisterProfileProtector> {
  // 프로필 이미지 받아오기
  XFile? _pickedFile; // 이미지를 담을 변수 선언
  CroppedFile? _croppedFile; // 크롭된 이미지 담을 변수 선언
  final List<XFile?> _pickedImages = []; // 이미지 여러개 담을 변수 선언
  final ImagePicker imagePicker = ImagePicker(); // ImagePicker 초기화

  var defaultImg = 'assets/ch_top_yellow.png';
  bool isDefault = false;

  // Textformfield 값 받아오기
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _timesController = TextEditingController();

  late bool validationResult;
  String _nickname = ''; // 내 닉네임
  String _times = ''; // 임시보호 횟수
  String _address = '';

  // 내 동네 카카오 API 값 컨트롤러
  TextEditingController _AddressController = TextEditingController();

  @override
  void initState() {
    validationResult = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 4;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            '프로필 등록하기',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Form(
          // form으로 input 데이터 저장
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Color(0xffFFF5BF),
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset('assets/ch_top_orange.png'),
                      ),
                      SizedBox(
                        child: Image.asset('assets/ic_balloon_pr.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  child: Text(
                    '보호자 프로필',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // 사진 등록
                if (_pickedFile == null)
                  Container(
                    constraints: BoxConstraints(
                      minHeight: _imageSize,
                      minWidth: _imageSize,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _showBottomSheet();
                      },
                      child: Center(
                        child: Image.asset('assets/img_register.png'),
                      ),
                    ),
                  )
                else
                  Center(
                      child: isDefault == false
                          ? Container(
                              width: _imageSize,
                              height: _imageSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                image: DecorationImage(
                                    image: FileImage(File(_pickedFile!.path)),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              width: _imageSize,
                              height: _imageSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                image: DecorationImage(
                                    image: AssetImage(defaultImg),
                                    fit: BoxFit.contain),
                              ),
                            )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 340,
                  child: Text(
                    '내 닉네임 *',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 내 닉네임 등록
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    maxLength: 14,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter(
                        RegExp('[a-z A-Z ㄱ-ㅎ|가-힣| ·|： 0-9]'),
                        allow: true,
                      )
                    ],
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        counterText: '',
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
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: '영문/한글/숫자만 가능해요'),
                    onSaved: (value) {
                      setState(() {
                        _nickname = value as String;
                        _nicknameController.value =
                            TextEditingValue(text: value);
                        formData['nickname'] = value;
                      });
                    },
                    // 유효성 검사
                    validator: (value) {
                      if (value!.isEmpty) return '닉네임을 입력해 주세요.';
                      if (value.toString().length <= 2)
                        return '닉네임은 두글자 이상 입력 해주셔야 합니다.';
                      return null;
                    },
                    controller: _nicknameController,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: Text(
                    '내 동네 *',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 내 동네 등록
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _addressAPI(); // 카카오 주소 API
                    },
                    child: TextFormField(
                      enabled: false,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                          isDense: false,
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
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: '주소 검색'),
                      controller: _AddressController,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: Text(
                    '임시보호 횟수',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                // 임시보호 횟수 등록
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
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
                        hintText: '없으셨다면 0으로 적어주세요!'),
                    onSaved: (value) {
                      setState(() {
                        _times = value as String;
                        _timesController.value = TextEditingValue(text: value);
                        formData['times'] = value;
                      });
                    },
                    controller: _timesController,
                  ),
                ),
                // 다음 단계로 이동하기
                // Text(validationResult ? 'Success' : 'Failed'),
                SizedBox(
                  height: 60,
                  width: 350,
                  child: Container(
                    height: 30,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFFFED8E)),
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
                                      Text(_nickname + '/' + '/' + _times)),
                            );

                            registerProtectorProfile(formData);

                            // 동물 프로필 등록 화면으로 이동
                            final result = await Navigator.of(context).push(_createRoute());
                          },
                        );
                      },
                      child: Text(
                        "다음 단계로 이동하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
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
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterProfileAnimal(),
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
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _getDefaultImage(),
              child: const Text('기본이미지'),
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
        _pickedFile = pickedFile;
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
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  // 기본이미지 설정
  _getDefaultImage() async {
    setState(() {
      isDefault = true;
      _pickedFile = Image.asset('assets/ch_top_yellow.png') as XFile?;
    });
  }

  // 카카오주소 API
  _addressAPI() async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    _AddressController.text =
    '${model.sido!} ${model.sigungu!} ${model.bname!}';

    final address = '${model.sido!} ${model.sigungu!} ${model.bname!}';
    _AddressController.value = TextEditingValue(text: address);
    formData['address'] = address;
  }

  Future registerProtectorProfile(data) async {
    try {
      final url = Uri.parse('http://13.209.51.119:8080/member/profile');
      final headers = {
        'Content-Type': 'application/json',
      };

      final testData = data['nickname'];
      final body = jsonEncode({
        'nickname': testData
      });

      final res = await http.post(url, headers: headers, body: body);
      print(res.statusCode);
      // print(res.body);

      print(data);
      print(body);
      // print(data['address']);
      // print(data['times']);

      return res;
    } catch (err) {
      print('err => ${err}');
    }
  }
}