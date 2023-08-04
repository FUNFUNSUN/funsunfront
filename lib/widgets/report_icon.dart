import 'package:flutter/material.dart';

import '../screens/report_screen.dart';

class ReportIcon extends StatelessWidget {
  late dynamic id;
  late String message;
  late String type;
  ReportIcon(this.id, this.type, this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> report = {
      'type': type,
      'message': message,
      'target': id
    };
    return InkWell(
      onTap: () {
        // print(report['target']);
        // print(report['type']);
        // print(report['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReportScreen(
              report,
            ),
          ),
        );
      },
      child: const SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '신고하기',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
