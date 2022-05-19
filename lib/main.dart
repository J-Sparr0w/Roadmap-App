import 'package:flutter/material.dart';
import 'package:roadmap_app/models/current_nodes_state.dart';
import 'package:roadmap_app/services/file_operations.dart';

import 'background.dart';

import 'node.dart';

import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Roadmap',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Background(
          child: DrawArea(),
        ),
      ),
    );
  }
}

class DrawArea extends StatefulWidget {
  const DrawArea({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawArea> createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  List<dynamic> jsonNodesList = [];
  List<Node> nodes = [];
  List<CustomPaint> lines = [];

  @override
  void initState() {
    super.initState();

    CurrentNodesState();
    nodes = CurrentNodesState.getNodes;
    lines = CurrentNodesState.getLines;
  }

  // void _repositionChild(String initValue, Offset offset) {
  //   print("dx = " + (offset.dx).toString() + ", dy= " + (offset.dy).toString());

  //   int index =
  //       draggedChildren.indexOf(Node(details: NodeDetails(text: initValue)));
  //   if (index >= 0) draggedChildren.removeAt(index);
  //   setState(() {
  //     draggedChildren.add(
  //       Node(
  //           details: NodeDetails(
  //               top: offset.dy - 40,
  //               left: offset.dx - 40,
  //               text: initValue,
  //               parentKey: null)),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      clipBehavior: Clip.none,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 4,
        height: MediaQuery.of(context).size.height * 4,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ...draggedChildren,
            ...nodes,
            ...lines
          ],
        ),
      ),
    );
  }
}

// class DropArea extends StatelessWidget {
//   const DropArea({Key? key, required this.onDragAccept}) : super(key: key);

//   final Function onDragAccept;

//   @override
//   Widget build(BuildContext context) {
//     return DragTarget<String>(
//       onAcceptWithDetails: (details) {
//         String data = details.data;
//         Offset offset = details.offset;

//         onDragAccept(data, offset);
//       },
//       builder: (context, data, rejectedData) {
//         return Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: const Color.fromARGB(0, 255, 255, 255),
//         );
//       },
//     );
//   }
// }
