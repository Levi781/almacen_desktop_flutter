
import 'package:flutter/material.dart';

class CreateUsersProvider extends ChangeNotifier{

  bool _isEnabled = true;

  bool get isEnabled => _isEnabled;

  set isEnabled(bool isEnabled) {
    _isEnabled = isEnabled;
    notifyListeners();
  }

}