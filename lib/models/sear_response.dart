// To parse this JSON data, do
//
//     final searcResponse = searcResponseFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_peliculas_app/models/movie.dart';

class SearcResponse {
  SearcResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Pelicula> results;
  int totalPages;
  int totalResults;

  factory SearcResponse.fromJson(String str) =>
      SearcResponse.fromMap(json.decode(str));

  factory SearcResponse.fromMap(Map<String, dynamic> json) => SearcResponse(
        page: json["page"],
        results: List<Pelicula>.from(
            json["results"].map((x) => Pelicula.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
