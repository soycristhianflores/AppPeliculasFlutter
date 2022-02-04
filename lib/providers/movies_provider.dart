
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/models/play_movies_response.dart';
import 'package:peliculas/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {


  String _apiKey   = '0e2a55b812d9cf50e057c5d91ac6ebfe';
  String _lenguage = 'es-ES';
  String _baseUrl  = 'api.themoviedb.org';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

 
  MoviesProvider(){
  print('Inicializado');

  getOnDisplayMovies();
  getPopularMovies();

  }

 

  //optimizacion de codigo
  Future<String> _getJsonData(String endpoint, [int page = 1]) async{
     var url = Uri.https(_baseUrl, endpoint, 
      {
        'api_key': _apiKey,
        'lenguage': _lenguage,
        'page': '$page'
      });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }


 getOnDisplayMovies() async {

   final jsonData = await _getJsonData('3/movie/now_playing');
   final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }


  getPopularMovies() async{
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies , ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId];

    print('actores....');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

}

