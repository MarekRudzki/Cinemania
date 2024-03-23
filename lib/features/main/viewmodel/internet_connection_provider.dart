// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionProvider extends ChangeNotifier {
  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;

  InternetConnectionProvider() {
    startInternetListener();
  }

  void startInternetListener() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        _hasInternet = true;
        notifyListeners();
      } else {
        _hasInternet = false;
        notifyListeners();
      }
    });
  }
}
