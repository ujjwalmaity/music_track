import 'package:flutter/material.dart';

class WidgetTrackDetails extends StatelessWidget {
  final String title;
  final String body;

  const WidgetTrackDetails({@required this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(body, style: TextStyle(color: Colors.black, fontSize: 18.0)),
        ],
      ),
    );
  }
}
