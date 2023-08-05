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
  final bankList = [];

  ListTile _tile(String title, String image) => ListTile(
        minVerticalPadding: 10,
        focusColor: Theme.of(context).primaryColorLight,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        title: Text(title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              image,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );

  Widget _bankList() => Expanded(
        child: ListView(
          children: [
            _tile("국민", 'assets/images/bank/bank_kb.png'),
            _tile("기업", 'assets/images/bank/bank_ibk.png'),
            _tile("농협", 'assets/images/bank/bank_nh.png'),
            // _tile("새마을", 'assets/images/bank/bank_mg.png'),
            // _tile("산업", 'assets/images/bank/bank_su.png'),
            // _tile("수협", 'assets/images/bank/bank_sh.png'),
            _tile("신한", 'assets/images/bank/bank_shinhan.png'),
            _tile("우리", 'assets/images/bank/bank_wr.png'),
            // _tile("우체국", 'assets/images/bank/bank_ucg.png'),
            _tile("하나", 'assets/images/bank/bank_hn.png'),
            // _tile("한국씨티", 'assets/images/bank/bank_hg.png'),
            _tile("SC제일", 'assets/images/bank/bank_sc.png'),
            _tile("카카오뱅크", 'assets/images/bank/bank_kko.png'),
            _tile("케이뱅크", 'assets/images/bank/bank_kBank.png'),
            _tile("토스", 'assets/images/bank/bank_ts.png'),
          ],
        ),
      );
  void setImage(File uploadedImage) {
    setState(() {
      editImage = uploadedImage;
    });
  }

  Map<String, dynamic> editData = {
    'user_name': "",
    'birthday': "",
    'bank_account': "",
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
    editData['bank_account'] = widget.origin.bankAccount;
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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '프로필 수정페이지입니다.',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                        color: Theme.of(context).primaryColor, Icons.close),
                  ),
                ],
              ),
              Text(
                '수정할 항목들을 입력하세요.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.origin.image == null)
                    ? (editImage == null)
                        ? Stack(
                            children: [
                              const CircleAvatar(
                                  //디폴트 프로필 이미지
                                  radius: 55,
                                  backgroundImage: AssetImage(
                                      'assets/images/default_profile.jpg')),
                              Positioned(
                                bottom: 5,
                                left: 80,
                                child: InkWell(
                                  onTap: () {
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
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                137, 173, 173, 173),
                                            blurRadius: .8,
                                            offset: Offset(0.0, 0.8))
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 19,
                                    ),
                                  ),
                                ),
                              ),
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
                const SizedBox(height: 20),
                (widget.origin.birthday == "")
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
                              setState(() {
                                editData['birthday'] = value;
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
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '계좌번호를 변경하시겠습니까?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '변경할 계좌번호를 입력하세요.',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        width: 150,
                                        height: 200,
                                        child: _bankList(),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text('확인'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(.5)),
                              width: 60,
                              height: 60,
                              child: const Text('은행 선택'),
                            )),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextFormField(
                            initialValue: widget.origin.username,
                            onChanged: (value) {
                              setState(() {
                                editData['bank_acount'] = value;
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
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      print(editData);
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
                      btnTxt: '프로필 수정',
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
