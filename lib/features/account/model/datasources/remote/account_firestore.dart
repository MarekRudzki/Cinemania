import 'package:cinemania/features/account/model/models/favorite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteUserData({
    required String uid,
  }) async {
    try {
      final collection = _firestore.collection('users');
      await collection.doc(uid).delete();
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<void> changeUsername({
    required String uid,
    required String username,
  }) async {
    try {
      final collection = _firestore.collection('users');
      await collection.doc(uid).update({
        'username': username,
      });
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<String> getUsername({
    required String uid,
  }) async {
    String username = '';
    try {
      final collection = _firestore.collection('users');
      final docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        username = data?['username'] as String;
      }
      return username;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<List<dynamic>> getUserFavorites({
    required String uid,
  }) async {
    try {
      List<dynamic> favorites = [];
      final collection = _firestore.collection('users');
      final docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        favorites = data?['favorites'] as List<dynamic>;
      }
      return favorites;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<void> addFavorite({
    required String uid,
    required Favorite favorite,
  }) async {
    try {
      List<dynamic> favorites = [];
      final collection = _firestore.collection('users');

      final docSnapshot = await collection.doc(uid).get();

      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        favorites = data?['favorites'] as List<dynamic>;

        favorites.add({
          'category': favorite.category.toString(),
          'gender': favorite.gender ?? 0,
          'id': favorite.id,
          'name': favorite.name,
          'url': favorite.url,
        });

        await collection.doc(uid).update({
          'favorites': favorites,
        });
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFavorite({
    required String uid,
    required int id,
  }) async {
    try {
      List<dynamic> favorites = [];
      final collection = _firestore.collection('users');

      final docSnapshot = await collection.doc(uid).get();

      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        favorites = data?['favorites'] as List<dynamic>;

        favorites.removeWhere((favorite) => favorite['id'] == id);

        await collection.doc(uid).update({
          'favorites': favorites,
        });
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<bool> isFavorite({
    required String uid,
    required int id,
  }) async {
    try {
      final collection = _firestore.collection('users');

      final docSnapshot = await collection.doc(uid).get();
      if (!docSnapshot.exists) return false;

      final data = docSnapshot.data();
      final List<dynamic> favorites = data?['favorites'] as List<dynamic>;

      return favorites.any((fav) => fav['id'] == id);
    } catch (e) {
      throw e.toString();
    }
  }
}
