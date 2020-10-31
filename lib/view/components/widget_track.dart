import 'package:flutter/material.dart';
import 'package:music_track/model/trending_music.dart';

class WidgetTrack extends StatelessWidget {
  final Track track;

  WidgetTrack({@required this.track});

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
                    Text(track.trackName, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                    Text(track.albumName, style: TextStyle(color: Colors.grey, fontSize: 16.0)),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                width: 90.0,
                child: Text(
                  track.artistName,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
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
