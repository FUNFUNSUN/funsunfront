import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../services/api_funding.dart';
import '../widgets/image_upload.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

const List<Widget> _publics = <Widget>[
  Text('Public'),
  Text('Private'),
];

class _EditScreenState extends State<EditScreen> {
  File? _image;
  final picker = ImagePicker();
  final List<bool> _selectedPublic = <bool>[true, false];
  int tempPublic = 0;
  String _selectedDate = "";
  final _titleTextEditController = TextEditingController();
  final _contentTextEditController = TextEditingController();
  final _goalAmountTextEditController = TextEditingController();

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
    );
    if (selected != null) {
      setState(() {
        _selectedDate = (DateFormat.yMMMd()).format(selected);
      });
    }
  }

  // Future getImage(ImageSource imageSource) async {
  //   final image = await picker.pickImage(source: imageSource);

  //   setState(() {
  //     _image = File(image!.path);
  //   });
  // }
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
    String dateStr = _selectedDate.toString();
    return MaterialApp(
      home: Scaffold(
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
                    height: 5,
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
                      hintText: '안녕',
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (_image != null)
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
                      IconButton(
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
                          (_image != null) ? Icons.delete : Icons.add,
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
                    '서포터의 마음을 사로잡아야 돈을 받지. 돈벌기가 쉽나?',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                      hintText: '안녕',
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
                  Text(
                    '수정이 불가합니다.',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 13,
                    ),
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
                    selectedBorderColor: Colors.blue[200],
                    fillColor: Colors.blue[400],
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
                    '수정이 불가합니다.',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                      hintText: '안녕',
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
                    '수정이 불가합니다.',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffF4F4F4),
                        ),
                        height: 30,
                        child: Text(dateStr),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () async {
                        int tempAmount =
                            int.parse(_goalAmountTextEditController.value.text);
                        bool tempPublicBool = tempPublic == 0 ? true : false;

                        if (_titleTextEditController.text.length < 2 ||
                            _titleTextEditController.text.length > 20 ||
                            _titleTextEditController.text.isEmpty) {
                          print('펀딩 제목을 확인해주세요.');
                        } else if (_contentTextEditController.text.length < 2 ||
                            _contentTextEditController.text.length > 255 ||
                            _contentTextEditController.text.isEmpty) {
                          print('펀딩 목적을 확인해주세요.');
                        } else if (tempAmount < 1000 || tempAmount > 10000000) {
                          print('펀딩 금액은 1,000원 이상, 10,000,000원 이하입니다.');
                        } else {
                          Map<String, dynamic> temp = {
                            'title': _titleTextEditController.text,
                            'content': _contentTextEditController.text,
                            'goal_amount':
                                _goalAmountTextEditController.value.text,
                            'expire_on': _selectedDate,
                            'public': tempPublicBool.toString()
                          };
                          print('아직 호출안됨');
                          bool postResult = await Funding.postFunding(temp);
                          print('API 호출은 됐음');
                          (postResult)
                              ? const Dialog(child: Text('됐다!'))
                              : const Dialog(child: Text('넌 좆됐어'));
                          // var url = Uri.parse('uri');
                          // final response = await http.post(url);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue,
                        ),
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
