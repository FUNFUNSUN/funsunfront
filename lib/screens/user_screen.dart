import 'package:flutter/material.dart';
import 'package:funsunfront/widgets/profile.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Profile(
                    userName: '안녕',
                    following: 12,
                    follower: 10,
                    //이렇게 하는게 맞는지 정확히는 모르겠음
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 500,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFF80C0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 펀딩',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: sizeX,
                    height: 150,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: imgUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 150,
                          height: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(imgUrls[index], //펀딩이미지
                              fit: BoxFit.cover),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
