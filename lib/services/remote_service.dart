import 'dart:convert';
import 'package:view_movie/models/movie_cast_list.dart';
import 'package:view_movie/models/popular_list.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Results>?> getPopularList() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=9bb89316d8693b06d7a84980b29c011f&language=vi-VN');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      var popularList = PopularList.fromJson(jsonDecode(json));

      return popularList.results;
    }
  }

  Future<List<Cast>?> getMovieCastList(String movieId) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=9bb89316d8693b06d7a84980b29c011f&language=vi-VN');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      var castList = MovieCast.fromJson(jsonDecode(json));

      return castList.cast;
    }
  }
}
