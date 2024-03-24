// ignore_for_file: avoid_dynamic_calls

// Dart imports:
import 'dart:math';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> userHaveFavorites({
    required String uid,
  }) async {
    try {
      final collection = _firestore.collection('users');

      final docSnapshot = await collection.doc(uid).get();
      if (!docSnapshot.exists) return false;

      final data = docSnapshot.data();
      final List<dynamic> favorites = data?['favorites'] as List<dynamic>;

      bool moviesExist = false;
      bool tvShowsExist = false;

      for (final favorite in favorites) {
        final category = favorite['category'];
        if (category == 'Category.movies') {
          moviesExist = true;
        } else if (category == 'Category.tvShows') {
          tvShowsExist = true;
        }
      }

      return moviesExist && tvShowsExist;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getRandomFavoriteId({
    required String uid,
    required String category,
  }) async {
    try {
      final collection = _firestore.collection('users');

      final docSnapshot = await collection.doc(uid).get();

      final data = docSnapshot.data();
      final List<dynamic> favorites = data?['favorites'] as List<dynamic>;

      final categoryFavorites = favorites
          .where((favorite) => favorite['category'] == category)
          .toList();

      final int randomIndex = Random().nextInt(categoryFavorites.length);
      return categoryFavorites[randomIndex]['id'] as int;
    } catch (e) {
      throw e.toString();
    }
  }
}
