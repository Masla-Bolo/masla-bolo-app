import 'package:masla_bolo_app/domain/model/base_model.dart';

import '../../helpers/helpers.dart';

class Paginate<T> {
  String? previous;
  String? next;
  int count;
  List<T> results;

  Paginate({
    this.previous,
    this.next,
    this.count = 0,
    List<T>? results,
  }) : results = results ?? List<T>.empty(growable: true);

  factory Paginate.empty() => Paginate();

  Paginate<T> copyWith({
    String? previous,
    String? next,
    int? count,
    List<T>? results,
  }) {
    return Paginate<T>(
      previous: previous ?? this.previous,
      next: next ?? this.next,
      count: count ?? this.count,
      results: results ?? this.results,
    );
  }

  factory Paginate.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) dataFromJson,
  ) {
    return Paginate<T>(
      count: json['count'],
      previous: json['previous'],
      next: json['next'],
      results: json['results'] is List && json['results'] != null
          ? parseList(json['results'], dataFromJson)
              .map((json) {
                final data = json as BaseModel;
                return data.toDomain();
              })
              .toList()
              .cast<T>()
          : [],
    );
  }

  Map<String, dynamic> toJson(List<Map<String, dynamic>> mappedIssues) => {
        'count': count,
        'previous': previous,
        'next': next,
        'results': mappedIssues,
      };
}
