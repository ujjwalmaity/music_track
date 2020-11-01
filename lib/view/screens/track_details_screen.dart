import 'package:flutter/material.dart';
import 'package:music_track/bloc/track_bloc.dart';
import 'package:music_track/model/trending_music.dart';
import 'package:music_track/repository/music_repository.dart';
import 'package:music_track/view/components/widget_error.dart';
import 'package:music_track/view/components/widget_loading.dart';
import 'package:music_track/view/components/widget_track_details.dart';

class TrackDetailsScreen extends StatefulWidget {
  static const String id = 'track_details_screen';

  @override
  _TrackDetailsScreenState createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  final TrackBloc _trackBloc = TrackBloc(musicRepository: MusicRepositoryImpl());

  @override
  void dispose() {
    super.dispose();
    _trackBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Details"),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Bookmark saved")));
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder<bool>(
            stream: _trackBloc.loaderStream,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data) {
                return WidgetLoading();
              } else {
                return Container();
              }
            },
          ),
          StreamBuilder<String>(
            stream: _trackBloc.errorStream,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data != "") {
                return WidgetError(message: snapshot.data);
              } else {
                return Container();
              }
            },
          ),
          StreamBuilder<Track>(
            stream: _trackBloc.trackStream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                Track track = snapshot.data;
                List<WidgetTrackDetails> widgetList = List();
                widgetList.add(WidgetTrackDetails(title: "Name", body: track.trackName));
                widgetList.add(WidgetTrackDetails(title: "Artist", body: track.artistName));
                widgetList.add(WidgetTrackDetails(title: "Album Name", body: track.albumName));
                widgetList.add(WidgetTrackDetails(title: "Explicit", body: (track.explicit == 1).toString()));
                widgetList.add(WidgetTrackDetails(title: "Rating", body: track.trackRating.toString()));
                if (_trackBloc.lyrics != null) widgetList.add(WidgetTrackDetails(title: "Lyrics", body: _trackBloc.lyrics.lyricsBody));
                return ListView.builder(
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) => widgetList[index],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
