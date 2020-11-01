import 'package:music_track/db/database_provider.dart';

class Music {
  int trackId;
  String trackName;

  Music({this.trackId, this.trackName});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TRACK_ID: trackId,
      DatabaseProvider.COLUMN_TRACK_NAME: trackName,
    };
    return map;
  }

  Music.fromMap(Map<String, dynamic> map) {
    trackId = map[DatabaseProvider.COLUMN_TRACK_ID];
    trackName = map[DatabaseProvider.COLUMN_TRACK_NAME];
  }
}
