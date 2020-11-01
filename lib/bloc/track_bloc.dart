import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_track/model/track_lyrics.dart';
import 'package:music_track/model/trending_music.dart';
import 'package:music_track/repository/music_repository.dart';
import 'package:music_track/util/constants.dart';

class TrackBloc {
  final MusicRepository musicRepository;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final _trackController = StreamController<Track>();
  Lyrics lyrics;
  final _loaderController = StreamController<bool>();
  final _errorController = StreamController<String>();

  Stream<Track> get trackStream => _trackController.stream;

  StreamSink<Track> get trackSink => _trackController.sink;

  Stream<bool> get loaderStream => _loaderController.stream;

  StreamSink<bool> get loaderSink => _loaderController.sink;

  Stream<String> get errorStream => _errorController.stream;

  StreamSink<String> get errorSink => _errorController.sink;

  TrackBloc({@required this.musicRepository}) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        _fetchTrack();
      } else {
        trackSink.add(null);
        lyrics = null;
        loaderSink.add(false);
        errorSink.add("No Internet Connection");
      }
    });
    _fetchTrack();
  }

  void _fetchTrack() async {
    trackSink.add(null);
    lyrics = null;
    loaderSink.add(true);
    errorSink.add("");
    try {
      Track track = await musicRepository.getTrackDetails(Constants.trackId);
      trackSink.add(track);
      _fetchLyrics(track);
    } on SocketException {
      loaderSink.add(false);
      errorSink.add("No Internet Connection");
    } catch (e) {
      loaderSink.add(false);
      errorSink.add(e.toString());
    }
  }

  void _fetchLyrics(Track track) async {
    try {
      Lyrics tempLyrics = await musicRepository.getTrackLyrics(track.trackId);
      lyrics = tempLyrics;
      trackSink.add(track);
    } on SocketException {
      // errorSink.add("No Internet Connection");
    } catch (e) {
      // errorSink.add(e.toString());
    }

    loaderSink.add(false);
  }

  void dispose() {
    _connectivitySubscription.cancel();
    _trackController.close();
    _loaderController.close();
    _errorController.close();
  }
}
