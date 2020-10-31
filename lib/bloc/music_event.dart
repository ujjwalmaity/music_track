import 'package:equatable/equatable.dart';

abstract class MusicEvent extends Equatable {}

class FetchTrackListMusicEvent extends MusicEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
