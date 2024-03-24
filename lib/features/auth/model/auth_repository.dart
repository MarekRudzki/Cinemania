// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:cinemania/features/auth/model/datasources/local/auth_hive.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_auth.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_firestore.dart';

@lazySingleton
class AuthRepository {
  final AuthFirestore authFirestore;
  final AuthAuth authAuth;
  final AuthHive authHive;

  AuthRepository({
    required this.authFirestore,
    required this.authAuth,
    required this.authHive,
  });

  Future<void> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authAuth.logInWithEmailPassword(
        email: email,
        password: password,
      );
      await authHive.saveUser(
        uid: authAuth.getUid(),
        username: email,
        loginMethod: 'email_password',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authAuth.registerWithEmailPassword(
        email: email,
        password: password,
      );
      await authHive.saveUser(
        uid: authAuth.getUid(),
        username: email,
        loginMethod: 'email_password',
      );
      await authFirestore.addUser(
        uid: authAuth.getUid(),
        username: email,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithCredential({
    required AuthCredential credential,
    required String username,
  }) async {
    try {
      await authAuth.signInWithCredential(
        credential: credential,
      );
      await authHive.saveUser(
        uid: authAuth.getUid(),
        username: username,
        loginMethod: 'social_media',
      );
      await authFirestore.addUser(
        uid: authAuth.getUid(),
        username: username,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await authAuth.resetPassword(
      email: email,
    );
  }

  bool isUserLogged() {
    return authHive.isUserLogged();
  }
}
