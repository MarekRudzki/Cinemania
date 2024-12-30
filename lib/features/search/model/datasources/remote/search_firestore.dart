// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:cinemania/features/search/model/models/search_history_entry.dart';

@lazySingleton
class SearchFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getUserSearches({required String uid}) async {
    try {
      List<dynamic> searches = [];
      final collection = _firestore.collection('users');
      final docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        searches = data?['searches'] as List<dynamic>;
      }

      return searches;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<void> addSearchToHistory({
    required String uid,
    required SearchHistoryEntry searchEntry,
  }) async {
    try {
      List<dynamic> searches = [];

      final collection = _firestore.collection('users');

      final docSnapshot = await collection.doc(uid).get();

      if (docSnapshot.exists) {
        final Map<String, dynamic>? data = docSnapshot.data();

        searches = (data?['searches'] as List<dynamic>?) ?? [];

        searches.removeWhere((item) =>
            item['text'] == searchEntry.text &&
            item['category'] == searchEntry.category.toString());

        searches.add({
          'text': searchEntry.text,
          'category': searchEntry.category.toString(),
        });

        await collection.doc(uid).update({
          'searches': searches,
        });
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
