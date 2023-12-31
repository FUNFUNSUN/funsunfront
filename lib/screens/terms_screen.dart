// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/screens/preview_screen.dart';

class TermsScreen extends StatelessWidget {
  Map<String, dynamic> temp;
  File? image;
  TermsScreen(this.temp, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 5,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                    color: Theme.of(context).primaryColor,
                    Icons.arrow_back_rounded),
              ),
              const SizedBox(
                width: 15,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이용약관을 확인해주세요',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '등록하시기 전, 이용약관을 반드시 확인해주세요',
                    style: TextStyle(color: Color(0xff7D7D7D), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: const Text(
                      'FunSun 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 FunSun 서비스의 이용과 관련하여 FunSun 서비스를 제공하는 FunSun 주식회사(이하 ‘FunSun’)와 이를 이용하는 FunSun 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 FunSun 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다. FunSun 서비스를 이용하시거나 FunSun 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다'),
                ),
                InkWell(
                  onTap: () {
                    print(temp);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewScreen(temp, image)),
                    );
                  },
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15)),
                        width: 400,
                        height: 50,
                        child: const Center(
                          child: Text(
                            '다음',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
