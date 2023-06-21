import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProfileAnimal extends StatefulWidget {
  const RegisterProfileAnimal({Key? key}) : super(key: key);

  @override
  State<RegisterProfileAnimal> createState() => _RegisterProfileAnimalState();
}

class _RegisterProfileAnimalState extends State<RegisterProfileAnimal> {
  // 프로필 이미지 받아오기
  XFile? _pickedFile; // 이미지를 담을 변수 선언
  CroppedFile? _croppedFile; // 크롭된 이미지 담을 변수 선언
  final List<XFile?> _pickedImages = []; // 이미지 여러개 담을 변수 선언
  final ImagePicker imagePicker = ImagePicker(); // ImagePicker 초기화

  // Textformfield 값 받아오기
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late bool validationResult;
  String _name = '';
  String _age = '' ;

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
                    '함께하는 임보 동물 프로필',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
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
                    child: Container(
                      width: _imageSize,
                      height: _imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary),
                        image: DecorationImage(
                            image: FileImage(File(_pickedFile!.path)),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 340,
                  child: Text(
                    '이름 *',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
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
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: '동물의 애칭을 적어주세요.'),
                    onSaved: (value) {
                      setState(() {
                        _name = value as String;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) return '이름을 입력해 주세요.';
                      if (value.toString().length <= 2)
                        return '이름은 두글자 이상 입력 해주셔야 합니다.';
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 340,
                  child: Text(
                    '나이',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
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
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: '모르실 경우 공란으로 두세요!'),
                    onSaved: (value) {
                      setState(() {
                        _age = value as String;
                      });
                    },
                    validator: (value) {
                      if (value!.contains(RegExp(r'[0-9]')))
                        return '숫자 입력은 불가능합니다.';
                      return null;
                    },
                  ),
                ),
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
                      onPressed: () => setState(
                        () async {
                          validationResult =
                              formKey.currentState?.validate() ?? false;
                          formKey.currentState!.save();

                          // 홈 화면으로 이동
                          final result =
                              await Navigator.pushNamed(context, '/main');
                        },
                      ),
                      child: Text(
                        "등록 완료하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
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
                            MaterialStateProperty.all(Color(0xFFF8F8F9)),
                      ),
                      onPressed: () async {
                        // 홈 화면으로 이동
                        final result =
                            await Navigator.pushNamed(context, '/main');
                      },
                      child: Text(
                        "나중에 등록하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 아래의 해당 함수(카메라, 갤러리)를 버튼과 연결
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
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}
