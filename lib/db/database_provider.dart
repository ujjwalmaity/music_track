import 'package:music_track/model/music.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_MUSIC = "music";
  static const String COLUMN_TRACK_ID = "trackId";
  static const String COLUMN_TRACK_NAME = "trackName";

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'musicDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          "CREATE TABLE $TABLE_MUSIC ("
          "$COLUMN_TRACK_ID INTEGER PRIMARY KEY,"
          "$COLUMN_TRACK_NAME TEXT"
          ")",
        );
      },
    );
  }

  Future<List<Music>> getMusics() async {
    final db = await database;

    var musics = await db.query(TABLE_MUSIC, columns: [COLUMN_TRACK_ID, COLUMN_TRACK_NAME]);

    List<Music> musicList = List<Music>();

    musics.forEach((currentMusic) {
      Music music = Music.fromMap(currentMusic);
      musicList.add(music);
    });

    return musicList;
  }

  Future<bool> insertMusic(Music music) async {
    final db = await database;

    try {
      music.trackId = await db.insert(TABLE_MUSIC, music.toMap());
    } catch (e) {
      return false;
    }

    return true;
  }
}
