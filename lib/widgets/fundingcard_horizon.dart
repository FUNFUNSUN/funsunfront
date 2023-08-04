import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:provider/provider.dart';

import '../provider/fundings_provider.dart';
import 'loading_circle.dart';

class FundingCardHorizon extends StatefulWidget {
  const FundingCardHorizon({
    super.key,
    required this.sizeX,
    required this.title,
    required this.fetchFunding,
    this.routeFunction,
  });
  final String title;
  final double sizeX;
  final Function? routeFunction;

  final Future<List<FundingModel>> Function(String page) fetchFunding;

  @override
  State<FundingCardHorizon> createState() => _FundingCardHorizonState();
}

class _FundingCardHorizonState extends State<FundingCardHorizon> {
  late List<FundingModel> _fundings;
  late bool _isLoading;
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
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.title),
            (widget.routeFunction != null)
                ? IconButton(
                    onPressed: () {
                      widget.routeFunction!();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                  )
                : const SizedBox(
                    width: 5,
                  ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
            width: widget.sizeX,
            height: 150,
            child: (_isLoading)
                ? const LoadingCircle()
                : (_fundings.isEmpty)
                    ? SizedBox(
                        height: 150,
                        child: Center(
                          child: Text(
                            '${widget.title}이 없습니다.',
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (!_isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _fetchData();
                            return true;
                          }
                          return false;
                        },
                        child: ListView.separated(
                          padding: const EdgeInsets.only(right: 20),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _fundings.length,
                          itemBuilder: (context, index) {
                            final funding = _fundings[index];
                            final String postid =
                                _fundings[index].id.toString();
                            final bool isExpired =
                                DateTime.parse(funding.expireOn)
                                    .isBefore(DateTime.now());
                            return GestureDetector(
                              onTap: () {
                                fundingsProvider.getFundingDetail(postid);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FundingScreen(
                                            id: postid,
                                          )),
                                );
                              },
                              child: Stack(children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: (funding.image != null)
                                      ? Image.network(
                                          '$baseurl${funding.image}',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/default_funding.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                (isExpired == true)
                                    ? Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .primaryColorLight),
                                          child: const Text(
                                            '만료된 \n펀딩',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10),
                                          ),
                                        ))
                                    : const SizedBox(
                                        width: 10,
                                      ),
                              ]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                        ),
                      )),
      ],
    );
  }
}
