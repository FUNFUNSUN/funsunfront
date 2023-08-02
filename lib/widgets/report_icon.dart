import 'package:flutter/material.dart';

import '../screens/report_screen.dart';

class ReportIcon extends StatelessWidget {
  late String id;
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
    return IconButton(
      icon: const Icon(Icons.campaign_outlined),
      color: Colors.black,
      onPressed: () {
        print(report['target']);
        print(report['type']);
        print(report['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReportScreen(
              report,
            ),
          ),
        );
      },
    );
  }
}
