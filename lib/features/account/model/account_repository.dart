// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:cinemania/features/account/model/datasources/local/account_hive.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_auth.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_firestore.dart';
import 'package:cinemania/features/account/model/models/favorite_model.dart';

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
      rethrow;
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
      rethrow;
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
      rethrow;
    }
  }

  Future<void> validateUserPassword({
    required String password,
  }) async {
    await accountAuth.validateUserPassword(
      password: password,
    );
  }

  Future<void> logout() async {
    await accountHive.deleteUser();
  }

  Future<void> saveUsernameFromFirebaseToHive() async {
    final uid = accountHive.getUid();
    final username = await accountFirestore.getUsername(uid: uid);
    await accountHive.saveUsername(username: username);
  }

  String getUsername() {
    return accountHive.getUsername();
  }

  String getLoginMethod() {
    return accountHive.getLoginMethod();
  }

  Future<List<Favorite>> getFavorites() async {
    try {
      final List<Favorite> favorites = [];
      final favoritesData = await accountFirestore.getUserFavorites(
        uid: accountAuth.getUid(),
      );
      if (favoritesData.isNotEmpty) {
        for (final favorite in favoritesData) {
          favorites.add(Favorite.fromJson(favorite as Map<String, dynamic>));
        }
      }

      return favorites;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFavorite({
    required Favorite favorite,
  }) async {
    await accountFirestore.addFavorite(
      uid: accountAuth.getUid(),
      favorite: favorite,
    );
  }

  Future<void> deleteFavorite({
    required int id,
  }) async {
    await accountFirestore.deleteFavorite(
      uid: accountAuth.getUid(),
      id: id,
    );
  }

  Future<void> updatePhotoUrl({
    required int itemId,
    required String newUrl,
  }) async {
    await accountFirestore.updatePhotoUrl(
      uid: accountAuth.getUid(),
      itemId: itemId,
      newUrl: newUrl,
    );
  }

  Future<String> getItemPhotoUrl({
    required int itemId,
  }) async {
    final photoUrl = await accountFirestore.getItemPhotoUrl(
      uid: accountAuth.getUid(),
      itemId: itemId,
    );
    return photoUrl;
  }
}
