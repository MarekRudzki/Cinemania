import 'package:hive_flutter/hive_flutter.dart';

class AuthLocalDatasource {
  final _userBox = Hive.box('user_box');

  Future<void> saveUser({required String user}) async {
    await _userBox.put('user', user);
  }

  bool isUserLogged() {
    return _userBox.containsKey('user');
  }
}
