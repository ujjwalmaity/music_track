import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_track/bloc/music_bloc.dart';
import 'package:music_track/bloc/music_event.dart';
import 'package:music_track/bloc/music_state.dart';
import 'package:music_track/model/trending_music.dart';
import 'package:music_track/util/constants.dart';
import 'package:music_track/view/components/widget_error.dart';
import 'package:music_track/view/components/widget_loading.dart';
import 'package:music_track/view/components/widget_track.dart';
import 'package:music_track/view/screens/about_screen.dart';
import 'package:music_track/view/screens/bookmarks_screen.dart';
import 'package:music_track/view/screens/track_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MusicBloc musicBloc;
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    musicBloc = BlocProvider.of<MusicBloc>(context);
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        musicBloc.add(FetchTrackListMusicEvent());
      } else {
        musicBloc.add(InternetConnectionLostMusicEvent());
      }
    });
    musicBloc.add(FetchTrackListMusicEvent());
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.collections_bookmark),
            onPressed: () {
              Navigator.pushNamed(context, BookmarksScreen.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(context, AboutScreen.id);
            },
          ),
        ],
      ),
      body: Container(
        child: BlocListener<MusicBloc, MusicState>(
          listener: (context, state) {
            if (state is ErrorMusicState) {
              // Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<MusicBloc, MusicState>(
            builder: (context, state) {
              if (state is InitialMusicState) {
                return WidgetLoading();
              } else if (state is LoadingMusicState) {
                return WidgetLoading();
              } else if (state is LoadedTrackListMusicState) {
                List<TrackList> trackList = state.trackList;
                return ListView.builder(
                  itemCount: trackList.length,
                  itemBuilder: (ctx, pos) {
                    return GestureDetector(
                      onTap: () {
                        Constants.trackId = trackList[pos].track.trackId;
                        Navigator.pushNamed(context, TrackDetailsScreen.id);
                      },
                      child: WidgetTrack(track: trackList[pos].track),
                    );
                  },
                );
              } else if (state is ErrorMusicState) {
                return WidgetError(message: state.message);
              } else {
                return WidgetError(message: "Connection Lost");
              }
            },
          ),
        ),
      ),
    );
  }
}
