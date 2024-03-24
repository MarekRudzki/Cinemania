// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthHive {
  final _userBox = Hive.box('user_box');

  Future<void> saveUser({
    required String uid,
    required String username,
    required String loginMethod,
  }) async {
    await _userBox.put('uid', uid);
    await _userBox.put('username', username);
    await _userBox.put('loginMethod', loginMethod);
  }

  bool isUserLogged() {
    return _userBox.containsKey('uid');
  }
}
