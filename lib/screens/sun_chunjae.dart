import 'package:flutter/material.dart';

class TestTest extends StatefulWidget {
  const TestTest({Key? key}) : super(key: key);

  @override
  State<TestTest> createState() => _TestTestState();
}

class _TestTestState extends State<TestTest> {
  List<String> imgUrls = [];

  String img01 =
      'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/298876936_1918903941641445_2522976767060187428_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=36a2c1&_nc_ohc=O6ovwXz3xG8AX_cWVac&_nc_ht=scontent-ssn1-1.xx&oh=00_AfD194FdhDi2p8lRzzogu3ZA7AzT9ANV6mpCQD4pkBPS2Q&oe=64C4E803';
  String img02 =
      'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/298526016_1918903974974775_7468393686721576102_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=973b4a&_nc_ohc=xI_Ge8Bz4loAX-a8j6T&_nc_ht=scontent-ssn1-1.xx&oh=00_AfD5ee6Gw1rfjHPhl36MTg7d7cp06zQQOPGvFWeUuz-hwg&oe=64C50A87';
  String img03 =
      'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/298954508_1918907558307750_4362470885833624974_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=973b4a&_nc_ohc=ZFGExodwrAcAX-EwGS-&_nc_ht=scontent-ssn1-1.xx&oh=00_AfBvsIuiSk1UvXVtWMr0cssrrGumkqOSx-5aysIMeXOx7A&oe=64C678C3';

  @override
  void initState() {
    imgUrls.add(img01);
    imgUrls.add(img02);
    super.initState();
  }

  Future<void> _onRefresh() async {
    // await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
    setState(() {
      imgUrls.add(img03);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          height: 700,
          decoration: const BoxDecoration(color: Colors.blueGrey),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ImgListView(imgUrls: imgUrls),
          ),
        ),
      ),
    );
  }
}

class ImgListView extends StatefulWidget {
  final List<String> imgUrls;

  const ImgListView({super.key, required this.imgUrls});

  @override
  State<ImgListView> createState() => _ImgListViewState();
}

class _ImgListViewState extends State<ImgListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.imgUrls.length,
      itemBuilder: (context, index) {
        return Image.network(widget.imgUrls[index]);
      },
    );
  }
}
