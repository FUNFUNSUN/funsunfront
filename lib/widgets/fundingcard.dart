import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/funding_model.dart';
import '../screens/funding_screen.dart';

class FundingCard extends StatefulWidget {
  const FundingCard({
    super.key,
    required this.sizeX,
    // required this.fundings,
    required this.title,
    required this.fetchFunding,
  });
  // final List<FundingModel> fundings;
  final Future<List<FundingModel>> Function(String page) fetchFunding;

  final double sizeX;
  final String title;

  @override
  State<FundingCard> createState() => _FundingCardState();
}

class _FundingCardState extends State<FundingCard> {
  final imgBaseUrl = 'http://projectsekai.kro.kr:5000/';
  late List<FundingModel> _fundings;
  bool _isLoading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fundings = [];
    _isLoading = true;

    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final newFundings = await widget.fetchFunding(_currentPage.toString());
      setState(() {
        _fundings.addAll(newFundings);
        _isLoading = false;
        _currentPage++;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching fundings: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_fundings.isNotEmpty)
        ? NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                _fetchData();
                return true;
              }
              return false;
            },
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
              itemCount: _fundings.length,
              physics: const AlwaysScrollableScrollPhysics(),

              // shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1.6, //item 의 가로 1, 세로 1 의 비율
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                //만료확인변수
                final bool isExpired = DateTime.parse(_fundings[index].expireOn)
                    .isBefore(DateTime.now());
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FundingScreen(
                                  id: _fundings[index].id.toString(),
                                )),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
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
                                  width: widget.sizeX,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: (_fundings[index].image != null)
                                        ? Image.network(
                                            '$imgBaseUrl${_fundings[index].image}',
                                            //펀딩이미지
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/default_funding.jpg',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _fundings[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  '펀딩종료일',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                Text(
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  DateFormat.yMMMd('en_US')
                                                      .format(DateTime.parse(
                                                          _fundings[index]
                                                              .expireOn)),
                                                ),
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
                        ),
                      ],
                    ));
              },
            ),
          )
        : Center(
            child: Text('${widget.title}이 없습니다.'),
          );
  }
}
