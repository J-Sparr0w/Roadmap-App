import 'package:flutter/material.dart';
import 'package:roadmap_app/models/current_nodes_state.dart';
// import 'line_painter.dart';
import 'models/node_details.dart';

class Node extends StatefulWidget {
  Node({Key? key, required this.details}) : super(key: key);

  final NodeDetails details;

  @override
  State<Node> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  String? textContent;
  double? top;
  double? left;

  @override
  void initState() {
    super.initState();
    textContent = widget.details.text;
    top = widget.details.top;
    left = widget.details.left;
    print("Node started");
  }

  bool _isHovering = false;
  bool _btnClicked = false;
  bool _dragging = false;

  void _showNewNodeBtn(bool isHover) {
    setState(() {
      _isHovering = (!_dragging) && isHover;
    });
  }

  void _setText(String value) {
    widget.details.text = value;
    textContent = value;
  }

  void _onNewNodeBtnPressed(ValueKey btnKey) {
    _btnClicked = true;
    Offset displacement = const Offset(0, 0);
//calculate the position of the new node and pass it to current_nodes_state
//create a new node with Node Details
    switch (btnKey.value) {
      case 'E':
        displacement = const Offset(100, 0);
        break;
      case 'N':
        displacement = const Offset(0, -100);
        break;
      case 'W':
        displacement = const Offset(-100, 0);
        break;
      case 'S':
        displacement = const Offset(0, 100);
        break;
    }
    final Offset newPosition =
        calculateNextNodePosition(displacement.dx, displacement.dy);
    final NodeDetails newNodeDetails =
        NodeDetails(top: newPosition.dy, left: newPosition.dx);

    CurrentNodesState.updateNodes(newNodeDetails);
  }

  Offset calculateNextNodePosition(double leftOffset, double topOffset) {
    return Offset(top! + topOffset, left! + leftOffset);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: MouseRegion(
        onEnter: (event) => _showNewNodeBtn(true),
        onExit: (event) => _showNewNodeBtn(false),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewNodeBtn(
              key: const ValueKey('W'),
              isHovering: _isHovering,
              onBtnPressed: _onNewNodeBtnPressed,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NewNodeBtn(
                  key: const ValueKey('N'),
                  isHovering: _isHovering,
                  onBtnPressed: _onNewNodeBtnPressed,
                ),
                Draggable<String>(
                  data: textContent,
                  feedback: NodeContent(
                    setText: _setText,
                    textContent: textContent,
                  ),
                  childWhenDragging: Container(),
                  onDragStarted: () {
                    setState(() {
                      _dragging = true;
                    });
                  },
                  onDraggableCanceled: (velocity, offset) {
                    setState(() {
                      _dragging = false;

                      top = top;
                      left = left;
                    });
                  },
                  onDragUpdate: (details) {
                    top = top! + details.delta.dy;
                    left = left! + details.delta.dx;
                  },
                  child: NodeContent(
                    setText: _setText,
                    textContent: textContent,
                  ),
                ),
                NewNodeBtn(
                  key: const ValueKey('S'),
                  isHovering: _isHovering,
                  onBtnPressed: _onNewNodeBtnPressed,
                ),
              ],
            ),
            NewNodeBtn(
              key: const ValueKey('E'),
              isHovering: _isHovering,
              onBtnPressed: _onNewNodeBtnPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class NodeContent extends StatefulWidget {
  const NodeContent({Key? key, required this.setText, this.textContent})
      : super(key: key);

  final Function setText;
  final String? textContent;

  @override
  State<NodeContent> createState() => _NodeContentState();
}

class _NodeContentState extends State<NodeContent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.textContent);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13.0,
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            LimitedBox(
              maxWidth: 150.0,
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  widget.setText(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "New Node",
                  isCollapsed: true,
                ),
                minLines: 1,
                maxLines: 10,
              ),
            ),
            const Icon(
              Icons.drag_indicator,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

class NewNodeBtn extends StatelessWidget {
  const NewNodeBtn(
      {Key? key, required this.onBtnPressed, required this.isHovering})
      : super(key: key);

  final Function onBtnPressed;
  final bool isHovering;

  @override
  Widget build(BuildContext context) {
    const addIcon = Icon(Icons.add);

    return Visibility(
      visible: isHovering,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        iconSize: 15.0,
        icon: addIcon,
        hoverColor: const Color.fromARGB(255, 117, 255, 216),
        alignment: Alignment.center,
        splashRadius: 10.0,
        onPressed: () {
          onBtnPressed(key);
        },
      ),
    );
  }
}
