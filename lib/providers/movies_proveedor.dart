import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/models/credits_response.dart';
import 'package:flutter_peliculas_app/models/movie.dart';
import 'package:flutter_peliculas_app/models/now_playinge_respuesta.dart';
import 'package:flutter_peliculas_app/models/popularpelis_respuesta.dart';
import 'package:flutter_peliculas_app/models/sear_response.dart';
import 'package:http/http.dart' as http;

class PeliculaProveedor extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '955bb050175b0934816cf18bf69cf514';
  String _lenguaje = 'es-ES';

  List<Pelicula> destacadosPeliculas = [];

  List<Pelicula> peliculasPopulares = [];

  Map<int, List<Cast>> movieCast = {};

  PeliculaProveedor() {
    print('PeliculasProveedor Inicializado');
    this.peliculasaMostrar();
  }
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _lenguaje, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  peliculasaMostrar() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _lenguaje, 'page': '1'});
    final response = await http.get(url);
    final noWPlayingRespuesta = NowPlayingRespuesta.fromJson(response.body);

    destacadosPeliculas = noWPlayingRespuesta.results;
    notifyListeners();
  }

  obtenerpeliculaspopulares() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _lenguaje, 'page': '1'});
    final response = await http.get(url);
    final popularRespuesta = PopularRespuesta.fromJson(response.body);

    peliculasPopulares = [...peliculasPopulares, ...popularRespuesta.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    //if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _lenguaje,
      'query': query,
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final searchMovie = SearcResponse.fromJson(response.body);
    return searchMovie.results;
  }
}
