import 'package:flutter/material.dart';

class PinkBtn extends StatelessWidget {
  final String btnTxt;
  final Function? onTapFn;
  const PinkBtn({
    required this.btnTxt,
    this.onTapFn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Text(
          btnTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}
