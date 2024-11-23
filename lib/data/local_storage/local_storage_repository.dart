import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/failures/local_storage_failure.dart';
import '../../domain/model/paginate.dart';
import '../../domain/model/user_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  static const String notFoundError = 'Value not found in local storage';
  static const String parseError = 'Failed to parse stored data';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<Either<LocalStorageFailure, T>> _getValue<T>({
    required String key,
    required T Function(String jsonStr) parser,
  }) async {
    try {
      final prefs = await _prefs;
      final value = prefs.getString(key);

      if (value?.isNotEmpty != true) {
        return left(LocalStorageFailure(error: notFoundError));
      }

      try {
        return right(parser(value!));
      } catch (e) {
        return left(LocalStorageFailure(error: '$parseError: ${e.toString()}'));
      }
    } catch (error) {
      return left(LocalStorageFailure(error: error.toString()));
    }
  }

  Future<Either<LocalStorageFailure, bool>> _setValue<T>({
    required String key,
    required T value,
    required String Function(T value) serializer,
  }) async {
    try {
      final prefs = await _prefs;
      final jsonStr = serializer(value);
      await prefs.setString(key, jsonStr);
      return right(true);
    } catch (error) {
      return left(LocalStorageFailure(error: error.toString()));
    }
  }

  Future<Either<LocalStorageFailure, String>> getValue(String key) async {
    return _getValue(
      key: key,
      parser: (str) => str,
    );
  }

  Future<Either<LocalStorageFailure, bool>> setValue(String key, String value) {
    return _setValue(
      key: key,
      value: value,
      serializer: (str) => str,
    );
  }

  Future<Either<LocalStorageFailure, UserEntity>> getUser(String key) {
    return _getValue(
      key: key,
      parser: (str) => UserJson.fromData(jsonDecode(str)).toDomain(),
    );
  }

  Future<Either<LocalStorageFailure, bool>> setUser(
      String key, UserEntity user) {
    return _setValue(
      key: key,
      value: user,
      serializer: (user) => jsonEncode(user.toJson()),
    );
  }

  Future<Either<LocalStorageFailure, Paginate<IssueEntity>>> getIssues(
      String key) {
    return _getValue(
      key: key,
      parser: (str) {
        final pagination =
            Paginate<IssueEntity>.fromJson(jsonDecode(str), IssueJson.fromJson);
        return pagination;
      },
    );
  }

  Future<Either<LocalStorageFailure, bool>> saveIssues(
    String key,
    Paginate<IssueEntity> pagination,
  ) {
    return _setValue(
      key: key,
      value: pagination.results,
      serializer: (issues) {
        final mappedIssues = issues.map((issue) => issue.toJson()).toList();
        return jsonEncode(pagination.toJson(mappedIssues));
      },
    );
  }

  Future<Either<LocalStorageFailure, IssueEntity>> getIssue(String key) {
    return _getValue(
      key: key,
      parser: (str) => IssueJson.fromJson(jsonDecode(str)).toDomain(),
    );
  }

  Future<Either<LocalStorageFailure, bool>> setIssue(
    String key,
    IssueEntity issue,
  ) {
    return _setValue(
      key: key,
      value: issue,
      serializer: (issue) => jsonEncode(issue.toJson()),
    );
  }

  Future<Either<LocalStorageFailure, bool>> deleteValue(String key) async {
    try {
      final prefs = await _prefs;
      await prefs.remove(key);
      return right(true);
    } catch (error) {
      return left(LocalStorageFailure(error: error.toString()));
    }
  }
}
