import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_track/bloc/music_event.dart';
import 'package:music_track/bloc/music_state.dart';
import 'package:music_track/model/trending_music.dart';
import 'package:music_track/repository/music_repository.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicRepository musicRepository;

  MusicBloc({@required this.musicRepository}) : super(ErrorMusicState(message: "No Internet Connection"));

  @override
  Stream<MusicState> mapEventToState(MusicEvent event) async* {
    if (event is InternetConnectionLostMusicEvent) {
      yield ErrorMusicState(message: "No Internet Connection");
    } else if (event is FetchTrackListMusicEvent) {
      yield LoadingMusicState();
      try {
        List<TrackList> trackList = await musicRepository.getTrackList();
        yield LoadedTrackListMusicState(trackList: trackList);
      } catch (e) {
        yield ErrorMusicState(message: e.toString());
      }
    }
  }
}
