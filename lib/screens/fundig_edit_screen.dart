import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/funding_model.dart';
import '../widgets/image_upload.dart';
import '../widgets/pink_btn.dart';

class FundingEditScreen extends StatefulWidget {
  final FundingModel origin;
  const FundingEditScreen({Key? key, required this.origin}) : super(key: key);

  @override
  State<FundingEditScreen> createState() => _FundingEditScreen();
}

const List<Widget> _publics = <Widget>[
  Text('Public'),
  Text('Private'),
];

class _FundingEditScreen extends State<FundingEditScreen> {
  File? editImage;
  final picker = ImagePicker();
  late final List<bool> _selectedPublic =
      widget.origin.public! == true ? <bool>[true, false] : <bool>[false, true];
  late int tempPublic = widget.origin.public! ? 0 : 1;
  String? originImage;

  Map<String, dynamic> editData = {
    'title': "",
    'content': "",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editData['title'] = widget.origin.title;
    editData['content'] = widget.origin.content;
    originImage = widget.origin.image;
  }

  void setImage(File uploadedImage) {
    setState(() {
      editImage = uploadedImage;
    });
  }

  final formKey = GlobalKey<FormState>();
  @required
  late FormFieldSetter onSaved;
  @required
  late FormFieldValidator validator;
  String name = '';
  @override
  Widget build(BuildContext context) {
    const String baseurl = 'http://projectsekai.kro.kr:5000/';

    Widget showImage() {
      if (originImage != null) {
        return Image.network(
          '$baseurl$originImage',
          fit: BoxFit.cover,
        );
      }
      return const SizedBox();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '수정할 펀딩 이름을 입력해주세요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '조금만 더 신중하게 지어봐요!',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  initialValue: editData['title'],
                  onChanged: (value) {
                    setState(() {
                      editData['title'] = value;
                    });
                  },
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
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '펀딩 이미지를 수정하세요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '수정하고싶지 않다면 넘어가도 돼요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                (originImage == null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Icons.add_a_photo),
                          ),
                        ],
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
                                  originImage = null;
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
                            child: showImage(),
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
                TextFormField(
                  initialValue: widget.origin.content.toString(),
                  onChanged: (value) {
                    setState(() {
                      editData['content'] = value;
                    });
                  },
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
                  ),
                  //controller: _contentTextEditController,
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
                  '나중에 수정 가능해요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    tempPublic == 0 ? true : false;
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
                const SizedBox(height: 30),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                      onTap: () async {
                        print('수정된 펀딩제목 :${editData['title']}');
                        print('수정된 펀딩목적 :${editData['content']}');
                        bool tempPublicBool = widget.origin.public!
                            ? tempPublic == 0
                                ? true
                                : false
                            : tempPublic == 1
                                ? false
                                : true;

                        print(tempPublicBool);

                        // print(postResult);

                        // Navigator.push(
                        // context,
                        //MaterialPageRoute(
                        //  builder: (context) => TermsScreen(temp, _image)),
                        //);
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
