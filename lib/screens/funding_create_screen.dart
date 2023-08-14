import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/screens/terms_screen.dart';
import 'package:funsunfront/widgets/app_bar.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/image_upload.dart';
import '../widgets/pink_btn.dart';

class FundingCreateScreen extends StatefulWidget {
  const FundingCreateScreen({super.key});

  @override
  State<FundingCreateScreen> createState() => _FundingCreateScreenState();
}

const List<Widget> _publics = <Widget>[
  Text('Public'),
  Text('Private'),
];

class _FundingCreateScreenState extends State<FundingCreateScreen> {
  File? _image;

  final List<bool> _selectedPublic = <bool>[true, false];
  int tempPublic = 0;
  String _selectedDate = "";
  final finalDate = "";
  final _titleTextEditController = TextEditingController();
  final _contentTextEditController = TextEditingController();
  final _goalAmountTextEditController = TextEditingController();
  late Map<String, dynamic> temp;

  DateTime tommorow = DateTime.now().add(const Duration(days: 1, hours: 9));
  DateTime today = DateTime.now().add(const Duration(hours: 9));

  late DateTime FD =
      int.parse(DateTime.now().add(const Duration(hours: 9)).hour.toString()) >=
              17
          ? DateTime.parse(tommorow.toString())
          : DateTime.parse(today.toString());

  Future _selectDate(BuildContext context) async {
    print(int.parse(
        DateTime.now().add(const Duration(hours: 9)).hour.toString()));

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: tommorow,
      firstDate: tommorow,
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
    );
    if (selected != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(selected);
      });
    }
  }

  void setImage(File uploadedImage) {
    setState(() {
      _image = uploadedImage;
    });
  }

  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    // final AccountModel user =
    Provider.of<UserProvider>(context, listen: true).user!;

    String dateStr = _selectedDate.toString();
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: const FunSunAppBar(
        title: '펀딩 작성 페이지입니다.',
        content: '작성할 내용들을 입력해주세요.',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '펀딩 이름을 입력해주세요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '센스있는 이름으로 특별한 펀딩을 만들어보세요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF4F4F4),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    hintText: '생일을 맞이하는 저에게 선물을 주세요!',
                  ),
                  controller: _titleTextEditController,
                ),
                const SizedBox(height: 30),
                const Text(
                  '펀딩 이미지를 첨부하세요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '펀딩 대표 이미지를 첨부하세요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (_image == null)
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ImageUpload(
                                setImage: setImage,
                              ),
                            ),
                          ).then((res) => setState(() {}));
                        },
                        icon: Icon(
                          color: Theme.of(context).primaryColor,
                          (_image != null)
                              ? Icons.delete
                              : Icons.add_a_photo_rounded,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ImageUpload(
                                        setImage: setImage,
                                      ),
                                    ),
                                  ).then((res) => setState(() {}));
                                },
                                icon: Icon(
                                    color: Theme.of(context).primaryColor,
                                    Icons.refresh),
                              ),
                              IconButton(
                                onPressed: () {
                                  _image = null;
                                  setState(() {
                                    showImage();
                                  });
                                },
                                icon: Icon(
                                    color: Theme.of(context).primaryColor,
                                    Icons.delete),
                              )
                            ],
                          ),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 100,
                            height: 100,
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '펀딩의 목적을 설명해주세요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '당신의 특별한 펀딩을 소개해보세요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(bottom: 100, top: 15, left: 10),
                    filled: true,
                    fillColor: const Color(0xffF4F4F4),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    hintText: '저의 생일을 위해 펀딩해주세요!',
                  ),
                  controller: _contentTextEditController,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '펀딩 공개여부',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '나중에 수정 가능해요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selectedPublic.length; i++) {
                        _selectedPublic[i] = i == index;
                      }
                      tempPublic = index;
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedColor: Colors.white,
                  selectedBorderColor: Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).primaryColor,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedPublic,
                  children: _publics,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '펀딩 목표금액',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '이후 수정이 불가합니다.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF4F4F4),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    hintText: '1000원부터 1000만원까지 가능해요',
                  ),
                  controller: _goalAmountTextEditController,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '펀딩 종료일',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '이후 수정이 불가합니다.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _selectedDate.isEmpty
                          ? const Icon(
                              Icons.calendar_month_outlined,
                              size: 25,
                            )
                          : const Icon(
                              Icons.refresh,
                              size: 25,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: screenWidth * 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xffF4F4F4),
                          ),
                          height: 30,
                          child: Center(child: Text(dateStr)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                      onTap: () async {
                        if (_titleTextEditController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('제목을 입력해주세요'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else if (_titleTextEditController.text.length < 2) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('제목은 두 글자 이상이어야합니다.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else if (_titleTextEditController.text.length > 50) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('제목은 50자 이하로 작성해주세요'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else if (_contentTextEditController.text.length < 2) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('내용은 두 글자 이상 작성해주세요'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else if (_contentTextEditController.text.length >
                            255) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title:
                                    const Text('내용이 너무 길어요! 255자 이하로 작성해주세요'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else if (_goalAmountTextEditController.text.isEmpty ||
                            int.parse(_goalAmountTextEditController.text) <
                                1000 ||
                            int.parse(_goalAmountTextEditController.text) >
                                10000000) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('가격을 확인해주세요'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else if (_selectedDate.isEmpty) {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('날짜를 선택해주세요'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            }),
                          );
                        } else {
                          bool tempPublicBool = tempPublic == 0 ? true : false;

                          //17시 들어가라.
                          String tmpDate = _selectedDate.toString();
                          String time = ' 17:00:00';
                          final finalDate = tmpDate + time;
                          DateTime tempDate = DateTime.parse(finalDate);

                          temp = {
                            'title': _titleTextEditController.text,
                            'content': _contentTextEditController.text,
                            'goal_amount':
                                _goalAmountTextEditController.value.text,
                            'expire_on': tempDate.toIso8601String(),
                            'public': tempPublicBool
                          };

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TermsScreen(temp, _image)),
                          );
                        }
                      },
                      child: const PinkBtn(
                        btnTxt: '펀딩 만들기',
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
