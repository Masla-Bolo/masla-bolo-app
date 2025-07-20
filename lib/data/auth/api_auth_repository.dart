import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masla_bolo_app/domain/entities/location.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/model/user_json.dart';
import '../../network/network_repository.dart';

import '../../domain/stores/user_store.dart';

class ApiAuthRepository implements AuthRepository {
  final UserStore userStore;
  final NetworkRepository networkRepository;
  ApiAuthRepository(this.userStore, this.networkRepository);

  @override
  Future<Either<AuthFailure, UserEntity>> login(
    String email,
    String password,
    String role,
  ) async {
    final response = await networkRepository.post(url: '/login/', data: {
      'email': email,
      'password': password,
      "role": role,
    });
    if (response.failed) {
      return left(AuthFailure(error: response.message));
    } else {
      signInWithEmailPassword(email: email, password: password);
      final data = response.data['user'];
      final user = UserJson.fromData(data).toDomain();
      userStore.setUser(user);
      return right(user);
    }
  }

  // incase of user registering it will return a string with email and incase of official it will return user in which there will be normal registration.
  @override
  Future<Either<AuthFailure, Either<String, UserEntity>>> register(
      UserEntity user) async {
    final response = await networkRepository.post(
      url: '/register/',
      data: user.toJson(),
    );
    if (response.failed) {
      return left(AuthFailure(error: response.message));
    } else if (response.data['email'] != null && !response.failed) {
      signInWithEmailPassword(
          email: user.email ?? "", password: user.password ?? "");
      return right(left(response.data['email']));
    } else if (response.data["user"] != null && !response.failed) {
      signInWithEmailPassword(
          email: user.email ?? "", password: user.password ?? "");
      final newUser = UserJson.fromData(response.data['user']).toDomain();
      userStore.setUser(newUser);
      return right(right(newUser));
    } else {
      return left(AuthFailure(error: response.message));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> sendEmail(String email) async {
    final response = await networkRepository
        .get(url: '/send-email-verification/', extraQuery: {
      'email': email,
    });
    return response.failed
        ? left(AuthFailure(error: response.message))
        : right(true);
  }

  @override
  Future<Either<AuthFailure, UserEntity>> verifyEmail(
      String email, String code) async {
    final response = await networkRepository.post(url: '/verify-email/', data: {
      'email': email,
      'code': code,
    });
    if (response.data["user"] != null) {
      final user = UserJson.fromData(response.data['user']).toDomain();
      userStore.setUser(user);
      return right(user);
    }
    return left(AuthFailure(error: response.message));
  }

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<AuthFailure, UserEntity>> googleSignIn(
      Location location) async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return left(AuthFailure(error: "Not Attempted to sign in!"));
    } else {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = UserEntity(
        username: result.user?.displayName ?? '',
        email: result.user?.email ?? '',
        image: result.user?.photoURL ?? '',
        isSocial: true,
        role: "user",
        location: location,
      );
      GoogleSignIn().signOut();

      final response = await networkRepository.post(
        url: '/social-register/',
        data: user.toJson(),
      );
      if (response.failed) {
        return left(AuthFailure(error: response.message));
      } else {
        final userJson = UserJson.fromData(response.data['user']).toDomain();
        userStore.setUser(userJson);
        return right(userJson);
      }
    }
  }
}
