// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';

class LinePainter extends CustomPainter {
  LinePainter({required this.from, required this.to});

  final Offset from;
  final Offset to;

  final Paint paintStyle = Paint()
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    LineType lineType = LineType(from: from, to: to);

    path.moveTo(from.dx, from.dy);

    if (from.dy == to.dy) {
      path.lineTo(to.dx, to.dy);
      return;
    }

    Offset _controlPt = lineType._controlPt;
    Offset _bezierStartingPt = lineType._bezierStartingPt;
    Offset _endingPt = lineType._endingPt;

    path.lineTo(_bezierStartingPt.dx, _bezierStartingPt.dy);
    path.quadraticBezierTo(
        _controlPt.dx, _controlPt.dy, _endingPt.dx, _endingPt.dy);

    Offset _secondControlPt = lineType._secondControlPt;
    Offset _secondEndingPt = lineType._secondEndingPt;

    path.quadraticBezierTo(_secondControlPt.dx, _secondControlPt.dy,
        _secondEndingPt.dx, _secondEndingPt.dy);

    canvas.drawPath(path, paintStyle);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    if (from != oldDelegate.from || to != oldDelegate.to)
      return true;
    else
      return false;
  }
}

class LineType {
  LineType({required this.from, required this.to}) {
    calculateLineType();
    setPointValues();
  }
  final Offset from;
  final Offset to;
  int _type = 0;

  late Offset _controlPt;
  late Offset _bezierStartingPt;
  late Offset _endingPt;
  late Offset _secondControlPt;
  late Offset _secondEndingPt;

  void calculateLineType() {
    //finds which quadrant line is going to be.
    if (to.dy > from.dy) {
      if (to.dx > from.dx)
        _type = 4;
      else
        _type = 3;
      return;
    }
    //first and second quadrant
    if (to.dx > from.dx)
      _type = 1;
    else
      _type = 2;
    return;
  }

  void setPointValues() {
    switch (_type) {
      case 0:
        break;
      case 1:
        _controlPt = Offset(to.dx - 20, from.dy);
        _bezierStartingPt = Offset(_controlPt.dx - 30, _controlPt.dy);
        _endingPt = Offset(to.dx - 10, to.dy + 10);
        _secondControlPt = Offset(_endingPt.dx, _endingPt.dy - 10);
        break;
      case 2:
        _controlPt = Offset(to.dx + 20, from.dy);
        _bezierStartingPt = Offset(_controlPt.dx + 30, _controlPt.dy);
        _endingPt = Offset(to.dx + 10, to.dy + 10);
        _secondControlPt = Offset(_endingPt.dx, _endingPt.dy - 10);
        break;
      case 3:
        _controlPt = Offset(to.dx + 20, from.dy);
        _bezierStartingPt = Offset(_controlPt.dx + 30, _controlPt.dy);
        _endingPt = Offset(to.dx + 10, to.dy - 10);
        _secondControlPt = Offset(_endingPt.dx, _endingPt.dy + 10);
        break;
      case 4:
        _controlPt = Offset(to.dx - 20, from.dy);
        _bezierStartingPt = Offset(_controlPt.dx - 30, _controlPt.dy);
        _endingPt = Offset(to.dx - 10, to.dy - 10);
        _secondControlPt = Offset(_endingPt.dx, _endingPt.dy + 10);
        break;
    }

    _secondEndingPt = Offset(to.dx, to.dy);
  }

  get getControlPt {
    return _controlPt;
  }

  get getBezierStartingPt {
    return _bezierStartingPt;
  }

  get getEndingPt {
    return _endingPt;
  }

  get getSecondControlPt {
    return _secondControlPt;
  }

  get getSecondEndingPt {
    return _secondEndingPt;
  }
}
