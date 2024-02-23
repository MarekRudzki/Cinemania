import 'package:hive_flutter/hive_flutter.dart';

class AuthLocalDatasource {
  final _userBox = Hive.box('user_box');

  Future<void> saveUser({required String user}) async {
    await _userBox.put('user', user);
  }

  String getUser() {
    return _userBox.get('user') as String;
  }

  bool isUserLogged() {
    return _userBox.containsKey('user');
  }

  Future<void> deleteUser() async {
    _userBox.delete('user');
  }
}
