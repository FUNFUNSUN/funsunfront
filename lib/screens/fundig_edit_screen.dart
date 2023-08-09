import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';

import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../services/api_funding.dart';
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
  bool imgdel = false;

  late final List<bool> _selectedPublic =
      widget.origin.public! == true ? <bool>[true, false] : <bool>[false, true];
  late int tempPublic = widget.origin.public! ? 0 : 1;
  String? originImage;

  Map<String, dynamic> editData = {
    'id': "",
    'title': "",
    'content': "",
    'public': true,
    'image_delete': ""
  };

  @override
  void initState() {
    super.initState();
    editData['id'] = widget.origin.id.toString();
    editData['title'] = widget.origin.title;
    editData['content'] = widget.origin.content;
    editData['public'] = widget.origin.public;
    originImage = widget.origin.image;
  }

  void setImage(File uploadedImage) {
    setState(() {
      editImage = uploadedImage;
      originImage = null;
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

    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '펀딩 이름을 수정하세요',
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
                  height: 10,
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
                  '수정하고싶지 않다면 넘어가요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                (originImage == null)
                    ? (editImage == null)
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
                                      imgdel = false;
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
                                      editImage = null;
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
                                  editImage!,
                                  fit: BoxFit.cover,
                                ),
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
                                  imgdel = false;
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
                                  imgdel = true;
                                  originImage = null;
                                  editImage = null;
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
                          Column(
                            children: [
                              const Text('기존이미지'),
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
                        ],
                      ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '펀딩의 목적을 수정하세요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '센스있는 문장으로 펀딩을 소개해보세요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Private은 친구만 보여요!',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                      if (imgdel) {
                        editData['image_delete'] = 'delete';
                      }
                      bool tempPublicBool = widget.origin.public!
                          ? tempPublic == 0
                              ? true
                              : false
                          : tempPublic == 1
                              ? false
                              : true;
                      editData['public'] = tempPublicBool;

                      if (editData['text'].toString().length > 20 ||
                          editData['text'].toString().length < 2) {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text('수정할 펀딩 제목을 확인해주세요.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('닫기'))
                              ],
                            );
                          }),
                        );
                      } else if (editData['content'].toString().length > 255 ||
                          editData['content'].toString().length < 2) {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text('수정할 펀딩 목적을 확인해주세요.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('닫기'))
                              ],
                            );
                          }),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('정말 수정하시겠습니까?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Map<String, dynamic> postResult =
                                            await Funding.putFunding(
                                                editData: editData,
                                                image: editImage);

                                        fundingsProvider.getFundingDetail(
                                            widget.origin.id.toString());
                                        fundingsProvider.getMyfundings(
                                            widget.origin.author!['id'], 1);
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('확인')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('취소')),
                                ],
                              );
                            }));
                      }
                    },
                    child: const PinkBtn(
                      btnTxt: '펀딩 수정하기',
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
}
