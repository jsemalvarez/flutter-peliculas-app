// To parse this JSON data, do
//
//     final popularRespose = popularResposeFromJson(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class PopularRespose {
  PopularRespose({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PopularRespose.fromRawJson(String str) =>
      PopularRespose.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory PopularRespose.fromJson(Map<String, dynamic> json) => PopularRespose(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  // Map<String, dynamic> toJson() => {
  //     "page": page,
  //     "results": List<dynamic>.from(results.map((x) => x.toJson())),
  //     "total_pages": totalPages,
  //     "total_results": totalResults,
  // };
}
