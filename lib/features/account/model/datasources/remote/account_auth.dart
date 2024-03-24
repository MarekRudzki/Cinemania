// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getUid() {
    return _auth.currentUser!.uid;
  }

  String? getEmail() {
    return _auth.currentUser!.email;
  }

  Future<void> deleteUser() async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: getEmail()!,
        password: currentPassword,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);

      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw 'Current password not correct';
      } else if (e.code == 'weak-password') {
        throw 'Password is weak';
      } else {
        throw 'Unknown error';
      }
    }
  }

  Future<void> validateUserPassword({
    required String password,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: getEmail()!,
        password: password,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw 'Password not correct';
      } else {
        throw 'Unknown error';
      }
    }
  }
}
