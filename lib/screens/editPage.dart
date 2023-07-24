import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
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
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
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
                  const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF4F4F4),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '안녕',
                    ),
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
                  SizedBox(
                    child: Column(children: [
                      FloatingActionButton(
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          print('눌림');
                          getImage(ImageSource.gallery);
                        },
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: const Color(0xffF4F4F4),
                        //   ),
                        // height: 110,
                        // width: 110,
                        // ),
                      ),
                    ]),
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
                  const TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 100),
                      filled: true,
                      fillColor: Color(0xffF4F4F4),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '안녕',
                    ),
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
                  const TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      // FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF4F4F4),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '안녕',
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
