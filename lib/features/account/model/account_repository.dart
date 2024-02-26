import 'package:cinemania/features/account/model/datasources/local/account_hive.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_auth.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountRepository {
  final AccountFirestore accountFirestore;
  final AccountAuth accountAuth;
  final AccountHive accountHive;

  AccountRepository({
    required this.accountFirestore,
    required this.accountAuth,
    required this.accountHive,
  });

  Future<void> deleteUser() async {
    try {
      await accountHive.deleteUser();
      await accountFirestore.deleteUserData(
        uid: accountAuth.getUid(),
      );
      await accountAuth.deleteUser();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await accountAuth.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changeUsername({
    required String username,
  }) async {
    try {
      await accountFirestore.changeUsername(
        uid: accountAuth.getUid(),
        username: username,
      );
      await accountHive.changeUsername(
        username: username,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    await accountHive.deleteUser();
  }

  Future<void> saveUsernameFromFirebaseToHive() async {
    final uid = accountHive.getUid();
    final username = await accountFirestore.getUsername(uid: uid);
    await accountHive.saveUsername(username: username);
  }
}
