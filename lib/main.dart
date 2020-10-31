import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_track/bloc/music_bloc.dart';
import 'package:music_track/repository/music_repository.dart';
import 'package:music_track/view/screens/about_screen.dart';
import 'package:music_track/view/screens/bookmarks_screen.dart';
import 'package:music_track/view/screens/home_screen.dart';
import 'package:music_track/view/screens/track_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Music Track",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) {
          return MusicBloc(musicRepository: MusicRepositoryImpl());
        },
        child: HomeScreen(),
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        BookmarksScreen.id: (context) => BookmarksScreen(),
        TrackDetailsScreen.id: (context) => TrackDetailsScreen(),
        AboutScreen.id: (context) => AboutScreen(),
      },
    );
  }
}
