import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser({
    required String uid,
    required String username,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'username': username,
        'favorites': [
          {},
        ],
      });
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
