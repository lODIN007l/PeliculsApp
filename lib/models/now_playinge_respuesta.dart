// To parse this JSON data, do
//
//     final nowPlayingRespuesta = nowPlayingRespuestaFromMap(jsonString);

import 'dart:convert';

import 'movie.dart';

class NowPlayingRespuesta {
  NowPlayingRespuesta({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Pelicula> results;
  int totalPages;
  int totalResults;

  factory NowPlayingRespuesta.fromJson(String str) =>
      NowPlayingRespuesta.fromMap(json.decode(str));

  factory NowPlayingRespuesta.fromMap(Map<String, dynamic> json) =>
      NowPlayingRespuesta(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Pelicula>.from(
            json["results"].map((x) => Pelicula.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}
