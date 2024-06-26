// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountHive {
  final _userBox = Hive.box('user_box');

  Future<void> deleteUser() async {
    await _userBox.delete('uid');
  }

  Future<void> changeUsername({
    required String username,
  }) async {
    await _userBox.put('username', username);
  }

  Future<void> saveUsername({
    required String username,
  }) async {
    await _userBox.put('username', username);
  }

  String getUid() {
    return _userBox.get('uid') as String;
  }

  String getUsername() {
    return _userBox.get('username') as String;
  }

  String getLoginMethod() {
    return _userBox.get('loginMethod') as String;
  }
}
