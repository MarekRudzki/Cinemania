import 'package:cinemania/features/auth/model/datasources/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepository({required this.authRemoteDatasource});

  Future<void> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await authRemoteDatasource.logInWithEmailPassword(
      email: email,
      password: password,
    );
  }

  Future<void> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await authRemoteDatasource.registerWithEmailPassword(
      email: email,
      password: password,
    );
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
  }) async {
    await authRemoteDatasource.signInWithCredential(
      credential: credential,
    );
  }
}
