import 'package:flutter/material.dart';
import 'package:music_track/db/database_provider.dart';
import 'package:music_track/model/music.dart';
import 'package:music_track/util/constants.dart';
import 'package:music_track/view/components/widget_bookmarks.dart';
import 'package:music_track/view/components/widget_error.dart';
import 'package:music_track/view/screens/track_details_screen.dart';

class BookmarksScreen extends StatefulWidget {
  static const String id = 'bookmarks_screen';

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Music> musics = List();

  void getMusics() {
    DatabaseProvider.db.getMusics().then((musicList) {
      setState(() {
        musics.addAll(musicList);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getMusics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: musics.length == 0 ? buildWidgetError() : buildListView(),
    );
  }

  WidgetError buildWidgetError() => WidgetError(message: "Bookmarks is Empty.\n\nSave song by clicking TrackDetailsScreen\'s Bookmarks button.");

  ListView buildListView() {
    return ListView.builder(
      itemCount: musics.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Constants.trackId = musics[index].trackId;
            Constants.trackName = musics[index].trackName;
            Navigator.pushNamed(context, TrackDetailsScreen.id);
          },
          child: WidgetBookmarks(trackId: musics[index].trackId, trackName: musics[index].trackName),
        );
      },
    );
  }
}
