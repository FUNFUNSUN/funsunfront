import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/services/api_funding.dart';

import '../widgets/achievement_rate.dart';
import 'funding_screen.dart';

class PreviewScreen extends StatefulWidget {
  Map<String, dynamic> temp;
  File? image;
  PreviewScreen(this.temp, this.image, {Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final leftDays = DateTime.parse(widget.temp['expire_on'])
            .difference(DateTime.now())
            .inDays +
        1;

    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                '펀딩 내용을 확인해주세요',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '업로드 전 미리 확인하는 페이지입니다.',
                style: TextStyle(color: Color(0xff7D7D7D)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                ),
                clipBehavior: Clip.hardEdge,
                child: widget.image != null
                    ? Image(image: FileImage(widget.image!))
                    : Image.network(
                        'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png',
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              AchievementRate(
                percent: 0,
                date: leftDays > 0 ? leftDays : 0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.temp['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.temp['content'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: GestureDetector(
                  onTap: () async {
                    // var json = jsonEncode(temp);

                    Map<String, dynamic> postResult =
                        await Funding.postFunding(widget.temp, widget.image, 2);

                    if (!mounted) return;

                    Navigator.of(context).popUntil((route) => route.isFirst);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FundingScreen(id: postResult['id'].toString())),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(15)),
                      width: 400,
                      height: 50,
                      child: const Center(
                        child: Text(
                          '등록하기',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      )),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
