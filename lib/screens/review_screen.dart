import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../services/api_funding.dart';
import '../widgets/image_upload.dart';
import '../widgets/pink_btn.dart';

class ReviewScreen extends StatefulWidget {
  final FundingModel origin;
  const ReviewScreen({Key? key, required this.origin}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreen();
}

class _ReviewScreen extends State<ReviewScreen> {
  File? editImage;
  final picker = ImagePicker();
  late final List<bool> _selectedPublic =
      widget.origin.public! == true ? <bool>[true, false] : <bool>[false, true];
  late int tempPublic = widget.origin.public! ? 0 : 1;
  String? originImage;

  Map<String, dynamic> editData = {'id': "", 'review': "", 'image_delete': ""};

  @override
  void initState() {
    super.initState();
    editData['id'] = widget.origin.id.toString();
    editData['review'] = widget.origin.review;
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
                  '리뷰를 작성해주세요!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '감사한 마음을 전해보세요!',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  initialValue: editData['review'],
                  onChanged: (value) {
                    setState(() {
                      editData['review'] = value;
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
                  '리뷰 사진을 올려주세요!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
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
                  '펀딩의 목적을 수정해주세요',
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
                const SizedBox(height: 30),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      if (editImage == null && originImage == null) {
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

                      print(editData);
                      print('edit데이터id =${editData['id']}');
                      print(widget.origin.id);

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
                                title: const Text('이대로 작성하시겠습니까?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Map<String, dynamic> postResult =
                                            await Funding.putFunding(
                                                editData: editData,
                                                image: editImage);

                                        print('put요청 이후');
                                        fundingsProvider.getFundingDetail(
                                            widget.origin.id.toString());
                                        fundingsProvider.getMyfundings(
                                            widget.origin.author!['id']);
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
                      btnTxt: '리뷰 작성하기',
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
