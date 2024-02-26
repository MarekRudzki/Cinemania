import 'package:cinemania/features/account/model/datasources/account_local_datasource.dart';
import 'package:cinemania/features/account/model/datasources/account_remote_datasource.dart';

class AccountRepository {
  final AccountLocalDatasource accountLocalDatasource;
  final AccountRemoteDatasource accountRemoteDatasource;

  AccountRepository({
    required this.accountLocalDatasource,
    required this.accountRemoteDatasource,
  });

  String getUsername() {
    return accountLocalDatasource.getUsername();
  }

  Future<void> deleteUser() async {
    // TODO delete from firestore
    await accountLocalDatasource.deleteUser();
  }

  Future<void> logout() async {
    await accountLocalDatasource.deleteUser();
  }
}
