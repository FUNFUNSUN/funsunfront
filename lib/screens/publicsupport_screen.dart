import 'package:flutter/material.dart';

import '../widgets/fundingcard.dart';

class PublicSupportScreen extends StatelessWidget {
  const PublicSupportScreen(
      {super.key,
      required this.FundingTitle,
      required this.FundingExpireDate,
      required this.FundingImage});

  final String FundingTitle;
  final String FundingExpireDate;
  final String FundingImage;

  @override
  Widget build(BuildContext context) {
    List<String> imgUrls = [];
    imgUrls.add(
        'https://flexible.img.hani.co.kr/flexible/normal/970/970/imgdb/original/2023/0619/20230619501341.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnSNkiSUcQ1o4jzsNDFSNYE1Bt3xmRZK3joQ&usqp=CAU');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');

    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '전체공개펀딩',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: const Color(0xffE7F5F6),
                      borderRadius: BorderRadius.circular(15)),
                  width: sizeX,
                  height: sizeY,
                  child: FundingCard(
                      imgUrls: imgUrls,
                      sizeX: sizeX,
                      FundingTitle: FundingTitle,
                      FundingExpireDate: FundingExpireDate),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
