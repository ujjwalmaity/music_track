import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_track/model/trending_music.dart';
import 'package:music_track/util/constants.dart';

abstract class MusicRepository {
  Future<List<TrackList>> getTrackList();
}

class MusicRepositoryImpl implements MusicRepository {
  @override
  Future<List<TrackList>> getTrackList() async {
    var response = await http.get(Constants.trendingMusicUrl);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<TrackList> trackList = TrendingMusic.fromJson(data).message.body.trackList;
      return trackList;
    } else {
      throw Exception();
    }
  }
}
