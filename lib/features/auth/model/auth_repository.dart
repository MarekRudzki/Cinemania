import 'package:cinemania/features/auth/model/datasources/local/auth_hive.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_auth.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      );
    } catch (e) {
      throw Exception(e);
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
      );
      await authFirestore.addUser(
        uid: authAuth.getUid(),
        username: email,
      );
    } catch (e) {
      throw Exception(e);
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
      );
      await authFirestore.addUser(
        uid: authAuth.getUid(),
        username: username,
      );
    } catch (e) {
      throw Exception(e);
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
