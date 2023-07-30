import 'package:flutter/cupertino.dart';

class FundingCardHorizon extends StatelessWidget {
  final String title;
  const FundingCardHorizon({
    super.key,
    required this.sizeX,
    required this.imgUrls,
    required this.title,
  });

  final double sizeX;
  final List<String> imgUrls;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 15,
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
    );
  }
}
