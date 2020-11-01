class Constants {
  static const String baseUrl = "https://api.musixmatch.com/ws/1.1/";
  static const String apiKey = "3f4dfab594831b16c11f14416dfeffa7"; // TODO: Provide valid api key from https://developer.musixmatch.com/plans
  static const String trendingMusicUrl = "${baseUrl}chart.tracks.get?apikey=$apiKey";
  static int trackId = 0;
  static String trackName = "";
  static const String trackDetailsUrl = "${baseUrl}track.get?apikey=$apiKey&track_id=";
  static const String trackLyricsUrl = "${baseUrl}track.lyrics.get?apikey=$apiKey&track_id=";
}
