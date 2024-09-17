import '../helpers/helpers.dart';

class ApiPagination<T> {
  String? previous;
  String? next;
  int count;
  List<T> results;

  ApiPagination({
    this.previous,
    this.next,
    this.count = 0,
    this.results = const [],
  });

  factory ApiPagination.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) dataFromJson,
  ) {
    return ApiPagination<T>(
      count: json['count'],
      previous: json['previous'],
      next: json['next'],
      results: json['results'] is List && json['results'] != null
          ? parseList(json['results'], dataFromJson)
          : [],
    );
  }
}
