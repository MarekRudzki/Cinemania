import 'package:cinemania/features/auth/model/datasources/auth_local_datasource.dart';
import 'package:cinemania/features/auth/model/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepository({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  Future<void> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDatasource.logInWithEmailPassword(
        email: email,
        password: password,
      );
      await authLocalDatasource.saveUser(user: email);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDatasource.registerWithEmailPassword(
        email: email,
        password: password,
      );
      await authLocalDatasource.saveUser(user: email);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await authRemoteDatasource.resetPassword(
      email: email,
    );
  }

  Future<void> signInWithCredential({
    required AuthCredential credential,
    required String username,
  }) async {
    try {
      await authRemoteDatasource.signInWithCredential(
        credential: credential,
      );
      await authLocalDatasource.saveUser(user: username);
    } catch (e) {
      throw Exception(e);
    }
  }

  bool isUserLogged() {
    return authLocalDatasource.isUserLogged();
  }
}
