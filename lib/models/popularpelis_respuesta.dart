// To parse this JSON data, do
//
//     final popularRespuesta = popularRespuestaFromMap(jsonString);

import 'dart:convert';

import 'movie.dart';

class PopularRespuesta {
  PopularRespuesta({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Pelicula> results;
  int totalPages;
  int totalResults;

  factory PopularRespuesta.fromJson(String str) =>
      PopularRespuesta.fromMap(json.decode(str));

  factory PopularRespuesta.fromMap(Map<String, dynamic> json) =>
      PopularRespuesta(
        page: json["page"],
        results: List<Pelicula>.from(
            json["results"].map((x) => Pelicula.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
