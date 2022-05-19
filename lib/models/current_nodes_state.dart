import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:roadmap_app/node.dart';

import '../line_painter.dart';
import 'node_details.dart';

class CurrentNodesState {
  static final CurrentNodesState _instance = CurrentNodesState._internal();

  factory CurrentNodesState() {
    return _instance;
  }
  CurrentNodesState._internal() {
    loadNodesFromFile();
  }
  static List<Node> _nodes = [];
  static List<CustomPaint> _lines = [];

  static get getNodes {
    return _nodes;
  }

  static get getLines {
    return _lines;
  }

  static void loadNodesFromFile() {
    // FileOperations.readFromFile().then((content) {
    //   if (content.isEmpty) return;
    //   jsonNodesList = jsonDecode(content);
    //   for (var node in nodesList) {
    //     _nodes.add(Node(details: NodeDetails.fromJson(node)));
    //   }
    // });
    _nodes.add(Node(
        details: NodeDetails.fromJson(
            {"top": 660, "left": 700, "text": "from file", "parentKey": "1"})));
    _nodes.add(Node(
        details: NodeDetails.fromJson(
            {"top": 500, "left": 700, "text": "from file", "parentKey": "1"})));
    _nodes.add(Node(
        details: NodeDetails.fromJson(
            {"top": 192, "left": 492, "text": "from file", "parentKey": "1"})));

    _lines.add(
      CustomPaint(
        painter: LinePainter(
            from: const Offset(300, 200), to: const Offset(100, 400)),
      ),
    );
  }

  void updateLines(Offset from, Offset to) {
    _lines.add(
      CustomPaint(
        painter: LinePainter(from: from, to: to),
      ),
    );
  }

  static void updateNodes(NodeDetails details) {
    _nodes.add(Node(details: details));
  }
}
