import 'package:cloud_firestore/cloud_firestore.dart';

class AccountFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteUserData({
    required String uid,
  }) async {
    try {
      final collection = _firestore.collection('users');
      await collection.doc(uid).delete();
    } on Exception catch (e) {
      throw Exception(e.toString());
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
      throw Exception(e.toString());
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
      throw Exception(e.toString());
    }
  }
}
