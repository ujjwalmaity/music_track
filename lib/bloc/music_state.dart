import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_track/model/trending_music.dart';

abstract class MusicState extends Equatable {}

class InitialMusicState extends MusicState {
  @override
  List<Object> get props => [];
}

class LoadingMusicState extends MusicState {
  @override
  List<Object> get props => [];
}

class LoadedTrackListMusicState extends MusicState {
  final List<TrackList> trackList;

  LoadedTrackListMusicState({@required this.trackList});

  @override
  List<Object> get props => throw UnimplementedError();
}

class ErrorMusicState extends MusicState {
  final String message;

  ErrorMusicState({@required this.message});

  @override
  List<Object> get props => throw UnimplementedError();
}
