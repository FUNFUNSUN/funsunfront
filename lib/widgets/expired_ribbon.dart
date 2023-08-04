import 'package:flutter/material.dart';

class RibbonContainer extends StatelessWidget {
  final String text;
  final Color ribbonColor;
  final Color textColor;

  const RibbonContainer({
    super.key,
    required this.text,
    this.ribbonColor = Colors.red,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: _RibbonPainter(ribbonColor),
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _RibbonPainter extends CustomPainter {
  final Color color;

  _RibbonPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
