import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';

import '../widgets/image_upload.dart';
import '../widgets/pink_btn.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.origin});
  final AccountModel origin;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late File _image;
  File? editImage;

  void setImage(File uploadedImage) {
    setState(() {
      editImage = uploadedImage;
    });
  }

  Map<String, dynamic> editData = {
    'user_name': "",
    'birthday': "",
    // 'title': "",
    // 'content': "",
    // 'public': true,
    // 'image_delete': ""
    //뱅크어카운트
    //생일
    //널이면, 생성가능
    //널 아니면 안보이게
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editData['user_name'] = widget.origin.username;
    editData['birthday'] = widget.origin.birthday;
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';

    Widget showImage() {
      if (editImage != null) {
        return Image.network(
          'baseurl${widget.origin.image}',
          fit: BoxFit.cover,
        );
      }
      return const SizedBox();
    }

    print(editData);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                          color: Theme.of(context).primaryColor, Icons.close),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '프로필 수정페이지입니다.',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '수정할 항목들을 입력하세요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                (widget.origin.image == null)
                    ? (editImage == null)
                        ? Row(
                            children: [
                              const CircleAvatar(
                                  //디폴트 프로필 이미지
                                  radius: 55,
                                  backgroundImage: AssetImage(
                                      'assets/images/default_profile.jpg')),
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
                                  Icons.add_a_photo_rounded,
                                ),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              CircleAvatar(
                                  //디폴트 프로필 이미지
                                  radius: 55,
                                  backgroundImage: FileImage(editImage!)),
                              Row(
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
                                      Icons.refresh,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      editImage = null;
                                      setState(() {
                                        showImage();
                                      });
                                    },
                                    icon: Icon(
                                      color: Theme.of(context).primaryColor,
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                    : Row(
                        children: [
                          CircleAvatar(
                              //업로드한 프로필 이미지(있으면)
                              radius: 60,
                              backgroundImage: FileImage(editImage!)),
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
                              (_image != null)
                                  ? Icons.delete
                                  : Icons.add_a_photo_rounded,
                            ),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '이름을 수정하시겠습니까?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '수정할 이름을 입력하세요.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.origin.username,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      editData['user_name'] = value;
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
                (widget.origin.birthday == null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '생일을 등록하시겠습니까?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '등록할 생일을 입력하세요.',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: widget.origin.username,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                editData['user_name'] = value;
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
                        ],
                      )
                    : const SizedBox(),
                Text('${widget.origin.birthday}'),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      print(editData['user_name']);
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text('정말 수정하시겠습니까?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
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
