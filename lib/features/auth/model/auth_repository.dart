import 'package:cinemania/features/auth/model/datasources/auth_remote_datasource.dart';

class AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepository({required this.authRemoteDatasource});

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await authRemoteDatasource.logIn(
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await authRemoteDatasource.register(
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
}
