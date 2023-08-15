import 'package:flutter/material.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

import '../services/api_account.dart';

class DropOutConfirmScreen extends StatelessWidget {
  const DropOutConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '약관을 확인해주세요',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '탈퇴하시기 전, 이용약관을 반드시 확인해주세요',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: const Text(
                      'FunSun 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 FunSun 서비스의 이용과 관련하여 FunSun 서비스를 제공하는 FunSun 주식회사(이하 ‘FunSun’)와 이를 이용하는 FunSun 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 FunSun 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다. FunSun 서비스를 이용하시거나 FunSun 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다'),
                ),
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('정말 탈퇴하시겠습니까?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    final status = await FunsunUser.delAccount(
                                        uid: userProvider.user!.id);

                                    print(status);
                                    userProvider.setLogin("");
                                    await UserApi.instance.unlink();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('확인')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('취소')),
                            ],
                          );
                        });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(15)),
                      width: 400,
                      height: 50,
                      child: const Center(
                        child: Text(
                          '탈퇴',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
