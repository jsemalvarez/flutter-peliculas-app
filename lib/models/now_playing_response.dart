// To parse this JSON data, do
//
//     final plyNowRespose = plyNowResposeFromJson(jsonString);

import 'dart:convert';

import 'movie.dart';

class NowPlayRespose {
  NowPlayRespose({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory NowPlayRespose.fromRawJson(String str) =>
      NowPlayRespose.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory NowPlayRespose.fromJson(Map<String, dynamic> json) => NowPlayRespose(
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
