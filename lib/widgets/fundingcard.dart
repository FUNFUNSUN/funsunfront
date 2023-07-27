import 'package:flutter/material.dart';

class FundingCard extends StatelessWidget {
  const FundingCard({
    super.key,
    required this.imgUrls,
    required this.sizeX,
    required this.FundingTitle,
    required this.FundingExpireDate,
  });

  final List<String> imgUrls;
  final double sizeX;
  final String FundingTitle;
  final String FundingExpireDate;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: imgUrls.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
        childAspectRatio: 1 / 1.6, //item 의 가로 1, 세로 1 의 비율
        mainAxisSpacing: 10, //수평 Padding
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 5.0,
                    offset: const Offset(1, .8))
              ]),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: SizedBox(
                  width: sizeX / 2,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                      imgUrls[index], //펀딩이미지
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(FundingTitle, overflow: TextOverflow.ellipsis),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('펀딩종료일'),
                                Text(FundingExpireDate),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
