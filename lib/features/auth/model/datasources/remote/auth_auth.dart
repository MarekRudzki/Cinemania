import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthAuth {
  final _auth = FirebaseAuth.instance;

  String getUid() {
    return _auth.currentUser!.uid;
  }

  Future<void> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('No Internet connection');
      } else if (e.code == 'wrong-password') {
        throw Exception('Given password is incorrect');
      } else if (e.code == 'user-not-found') {
        throw Exception('No user found for given email');
      } else if (e.code == 'too-many-requests') {
        throw Exception('Too many attempts, please try again later');
      } else if (e.code == 'invalid-email') {
        throw Exception('Email adress is not valid');
      } else {
        throw Exception('Unknown error');
      }
    }
  }

  Future<void> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('No Internet connection');
      } else if (e.code == 'invalid-email') {
        throw Exception('Email adress is not valid');
      } else if (e.code == 'weak-password') {
        throw Exception('Given password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Account with given email already exist');
      } else {
        throw Exception('Unknown error');
      }
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw Exception('Email adress is not valid');
      } else if (e.code == 'user-not-found') {
        throw Exception('User not found');
      } else {
        throw Exception('Unknown error');
      }
    }
  }

  Future<void> signInWithCredential({
    required AuthCredential credential,
  }) async {
    await _auth.signInWithCredential(credential);
  }
}
