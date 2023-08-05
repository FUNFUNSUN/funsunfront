import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:funsunfront/widgets/date_picker.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../widgets/image_upload.dart';
import '../widgets/pink_btn.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.origin});
  final AccountModel origin;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? _image;
  File? editImage;
  late UserProvider _userProvider;
  String tempBankAccount = "";
  String tempBank = "";

  ListTile _tile(String title, String image) => ListTile(
        onTap: () {
          setState(() {
            tempBank = title;
          });

          print(tempBank);
          print(title);
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
    });
  }

  //생일 관련
  void setBirth(DateTime birth) {
    setState(() {
      String strBirthMonth = birth.month.toString();
      String strBirthDay = birth.day.toString();

      if (int.parse(strBirthMonth) < 10) {
        strBirthMonth = '0$strBirthMonth';
      }
      if (int.parse(strBirthDay) < 10) {
        strBirthDay = '0$strBirthDay';
      }

      editData['birthday'] = strBirthMonth + strBirthDay;
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
  }

  @override
  Widget build(BuildContext context) {
    print('현재 계좌번호 : ${widget.origin.bankAccount}');

    late String bankCompany;
    late String bankNumber;

    // if (widget.origin.bankAccount == null || widget.origin.bankAccount == "") {
    //   bankCompany = "";
    //   bankNumber = "";
    // } else {
    //   String bank = widget.origin.bankAccount.toString();
    //   bankCompany = bank.substring(0, bank.indexOf(' '));
    //   bankNumber = bank.substring(bank.indexOf(' '), bank.length);
    // }

    if (widget.origin.bankAccount.toString() == "" ||
        widget.origin.bankAccount.toString() == "null" ||
        widget.origin.bankAccount.toString().isEmpty) {
      bankCompany = "";
      bankNumber = "";
    } else {
      String bank = widget.origin.bankAccount.toString();
      bankCompany = bank.substring(0, bank.indexOf(' '));
      bankNumber = bank.substring(bank.indexOf(' '), bank.length);
    }

    //////////////////////////계좌//////////////////////////
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    DateTime tmpBirth = (widget.origin.birthday == null)
        ? DateTime.now()
        : DateTime.parse('1996${widget.origin.birthday!}');
    DateTime birthMothDayOnly = DateTime(tmpBirth.month, tmpBirth.day);

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
                              backgroundImage: NetworkImage(
                                  '$baseUrl${widget.origin.image}')),
                          IconButton(
                            onPressed: () {
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
                    DatePicker(
                        setInfo: setBirth, defaultDate: birthMothDayOnly),
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
                            child: (widget.origin.bankAccount == "" ||
                                    widget.origin.bankAccount == null)
                                ? (tempBank == "")
                                    ? Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(.5)),
                                        width: 160,
                                        height: 60,
                                        child: const Text('은행 선택'))
                                    : Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(.5)),
                                        width: 160,
                                        height: 60,
                                        child: Text(tempBank))
                                : (tempBank == "")
                                    ? Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(.5)),
                                        width: 160,
                                        height: 60,
                                        child: Text(bankCompany))
                                    : Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(.5)),
                                        width: 160,
                                        height: 60,
                                        child: Text(tempBank),
                                      )),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            initialValue: (widget.origin.bankAccount == null)
                                ? ""
                                : bankNumber,
                            onChanged: (value) {
                              setState(() {
                                if (widget.origin.bankAccount.toString() !=
                                    "") {
                                  tempBankAccount =
                                      editData['bank_account'].toString();

                                  tempBankAccount = value.toString();
                                } else {
                                  tempBankAccount = value.toString();
                                }
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
                                        if (tempBank.toString().isEmpty ||
                                            tempBank.toString() == "") {
                                          tempBank = bankCompany;
                                        }
                                        if (tempBankAccount
                                                .toString()
                                                .isEmpty ||
                                            tempBankAccount.toString() == "") {
                                          tempBankAccount = bankNumber;
                                        }

                                        editData['bank_account'] =
                                            '$tempBank $tempBankAccount';

                                        // 유저정보 수정 API

                                        await User.putProfile(
                                            editData: editData,
                                            image: editImage);
                                        //provider 수정
                                        _userProvider.setUser(
                                            await User.getProfile(
                                                uid: _userProvider.user!.id));

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
