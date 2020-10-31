import 'package:equatable/equatable.dart';

abstract class MusicEvent extends Equatable {}

class InternetConnectionLostMusicEvent extends MusicEvent {
  @override
  List<Object> get props => [];
}

class FetchTrackListMusicEvent extends MusicEvent {
  @override
  List<Object> get props => [];
}
