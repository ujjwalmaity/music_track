import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_track/model/track_lyrics.dart';
import 'package:music_track/model/trending_music.dart';
import 'package:music_track/model/track_detalis.dart';
import 'package:music_track/util/constants.dart';

abstract class MusicRepository {
  Future<List<TrackList>> getTrackList();

  Future<Track> getTrackDetails(int trackId);

  Future<Lyrics> getTrackLyrics(int trackId);
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

  @override
  Future<Track> getTrackDetails(int trackId) async {
    var response = await http.get(Constants.trackDetailsUrl + trackId.toString());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Track track = TrackDetails.fromJson(data).message.body.track;
      return track;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Lyrics> getTrackLyrics(int trackId) async {
    var response = await http.get(Constants.trackLyricsUrl + trackId.toString());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Lyrics lyrics = TrackLyrics.fromJson(data).message.body.lyrics;
      return lyrics;
    } else {
      throw Exception();
    }
  }
}
