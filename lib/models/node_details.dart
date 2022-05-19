class NodeDetails {
  NodeDetails({this.top, this.left, this.text, this.parentKey});
  NodeDetails.fromJson(Map<String, dynamic> json)
      : top = json['top'].toDouble(),
        left = json['left'].toDouble(),
        text = json['text'],
        parentKey = json['parentKey'];
  final double? top;
  final double? left;
  String? text;
  final String? parentKey;
}
