import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        willChange: false,
        painter: const DotsPainter(),
        child: child,
      ),
    );
  }
}

class DotsPainter extends CustomPainter {
  const DotsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    PointMode pointMode = PointMode.points;
    Paint paintDetails = Paint()
      ..strokeWidth = 1.5
      ..color = Colors.black38;
    List<Offset> points = [];

    for (int i = 0; i < size.width; i += 20) {
      for (int j = 0; j < size.height; j += 20) {
        Offset point = Offset(i.toDouble(), j.toDouble());
        points.add(point);
      }
    }
    canvas.drawPoints(pointMode, points, paintDetails);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
