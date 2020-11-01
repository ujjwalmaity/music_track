import 'package:flutter/material.dart';

class WidgetBookmarks extends StatelessWidget {
  final int trackId;
  final String trackName;

  WidgetBookmarks({@required this.trackId, @required this.trackName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.library_music, color: Colors.grey, size: 30.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(trackName, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                    Text(trackId.toString(), style: TextStyle(color: Colors.grey, fontSize: 16.0)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(height: 2, color: Colors.black12),
        ],
      ),
    );
  }
}
