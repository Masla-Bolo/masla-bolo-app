import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/local_storage_failure.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrimaryLocalStorageRepository implements LocalStorageRepository {
  PrimaryLocalStorageRepository();
  @override
  Future<Either<LocalStorageFailure, String>> getValue(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(key);
      if (value?.isNotEmpty == true) {
        return right(value!);
      } else {
        return left(LocalStorageFailure(error: ''));
      }
    } catch (error) {
      return left(LocalStorageFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<LocalStorageFailure, bool>> setValue(
    String key,
    String value,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return right(true);
    } catch (error) {
      return left(LocalStorageFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<LocalStorageFailure, bool>> deleteValue(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
      return right(true);
    } catch (error) {
      return left(LocalStorageFailure(error: error.toString()));
    }
  }
}
