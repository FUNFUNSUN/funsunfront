import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:provider/provider.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../provider/user_provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/image_upload.dart';
import '../widgets/pink_btn.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.origin});
  final AccountModel origin;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? editImage;
  late UserProvider _userProvider;
  String tempBankAccount = "";
  String tempBank = "";
  late DateTime birthMothDayOnly;
  late int initialMonth;
  late int initialDay;
  bool imgdel = false;

  late int editMonth;
  late int editDay;

  late String? bankCompany;
  late String? bankNumber;

  ListTile _tile(String title, String image) => ListTile(
        onTap: () {
          setState(() {
            tempBank = title;
          });

          Navigator.pop(context);
        },
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
            _tile("신한", 'assets/images/bank/bank_shinhan.png'),
            _tile("우리", 'assets/images/bank/bank_wr.png'),
            _tile("하나", 'assets/images/bank/bank_hn.png'),
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
      widget.origin.image = null;
    });
  }

  Map<String, dynamic> editData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editData['user_name'] = widget.origin.username;
    editData['birthday'] = widget.origin.birthday;
    editData['bank_account'] = widget.origin.bankAccount;
    editData['image_delete'] = "";

    if (widget.origin.bankAccount == null) {
      bankCompany = "";
      bankNumber = "";
    } else {
      String bank = widget.origin.bankAccount!;
      List splitBank = bank.split(' ');
      try {
        bankCompany = splitBank[0];
        tempBank = bankCompany!;
        bankNumber = splitBank[1];
        tempBankAccount = bankNumber!;
      } catch (e) {
        tempBank = "";
        tempBankAccount = "";
      }
    }

    if (widget.origin.birthday == null) {
      initialMonth = 6;
      initialDay = 4;
    } else {
      initialMonth = int.parse(widget.origin.birthday!.substring(0, 2));
      initialDay = int.parse(widget.origin.birthday!.substring(2, 4));

      editMonth = initialMonth;
      editDay = initialDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    _userProvider = Provider.of<UserProvider>(context, listen: false);

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
      appBar: const FunSunAppBar(
        title: '프로필 수정 페이지입니다.',
        content: '수정할 항목들을 입력하세요.',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                                      Icons.add_a_photo,
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
                                      Icons.refresh,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      imgdel = true;
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
                              backgroundImage: NetworkImage(
                                  '$baseUrl${widget.origin.image}')),
                          IconButton(
                            onPressed: () {
                              imgdel = true;
                              widget.origin.image = null;
                              editImage = null;
                              setState(() {
                                showImage();
                              });
                            },
                            icon: Icon(
                                color: Theme.of(context).primaryColor,
                                Icons.delete),
                          ),
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
                              Icons.refresh,
                            ),
                          ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '생일을 수정하시겠습니까?',
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WheelChooser.integer(
                            onValueChanged: (p0) {
                              editMonth = p0;
                            },
                            initValue: initialMonth,
                            itemSize: 35,
                            selectTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            maxValue: 12,
                            minValue: 1,
                            listHeight: 80,
                            listWidth: 50,
                            isInfinite: true,
                          ),
                          const Text('월'),
                          WheelChooser.integer(
                            onValueChanged: (p0) {
                              editDay = p0;
                            },
                            initValue: initialDay,
                            itemSize: 35,
                            selectTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            maxValue: 31,
                            minValue: 1,
                            listHeight: 80,
                            listWidth: 50,
                            isInfinite: true,
                          ),
                          const Text('일')
                        ],
                      ),
                    )
                    //DatePicker(setInfo: setBirth, defaultDate: DateTime.now()),
                  ],
                ),
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
                      '변경할 계좌번호를 입력하세요. (- 없이 숫자만 입력)',
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
                                    content: Scrollbar(
                                      thumbVisibility: true,
                                      child: SizedBox(
                                        width: 150,
                                        height: 200,
                                        child: _bankList(),
                                      ),
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
                          child: (tempBank == "")
                              ? Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(.5)),
                                  width: 100,
                                  height: 60,
                                  child: const Text('은행 선택'))
                              : Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .primaryColorLight
                                          .withOpacity(.5)),
                                  width: 100,
                                  height: 60,
                                  child: Text(tempBank),
                                ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            initialValue: tempBankAccount,
                            onChanged: (value) {
                              setState(() {
                                tempBankAccount = value.toString();
                                print(tempBankAccount);
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
                      String editMonthStr;
                      String editDayStr;
                      editData['bank_account'] = '$tempBank $tempBankAccount';
                      print(editData['bank_account']);
                      if (editMonth < 10) {
                        editMonthStr = '0$editMonth';
                      } else {
                        editMonthStr = editMonth.toString();
                      }
                      if (editDay < 10) {
                        editDayStr = '0$editDay';
                      } else {
                        editDayStr = editDay.toString();
                      }
                      editData['birthday'] = '$editMonthStr$editDayStr';
                      print('${editData['birthday']}');

                      if (imgdel) {
                        editData['image_delete'] = 'delete';
                      }
                      showDialog(
                          context: context,
                          builder: ((context) {
                            if (editData['user_name'].toString().length < 2 ||
                                editData['user_name'].toString().length > 20) {
                              return AlertDialog(
                                title: const Text('이름을 확인하세요'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('닫기'))
                                ],
                              );
                            } else if (editData['bank_account']
                                        .toString()
                                        .length >
                                    28 ||
                                editData['bank_account'].toString().isEmpty) {
                              return AlertDialog(
                                title: const Text('계좌번호를 확인하세요'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('닫기'))
                                ],
                              );
                            } else {
                              return AlertDialog(
                                title: const Text('정말 수정하시겠습니까?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        // 유저정보 수정 API
                                        await User.putProfile(
                                            editData: editData,
                                            image: editImage);
                                        //provider 수정
                                        _userProvider.updateUser();
                                        print(editData['bank_account']);
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
                            }
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
