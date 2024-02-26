import 'package:hive_flutter/hive_flutter.dart';

class AccountLocalDatasource {
  final _userBox = Hive.box('user_box');

  String getUsername() {
    return _userBox.get('user') as String;
  }

  Future<void> deleteUser() async {
    await _userBox.delete('user');
  }
}
