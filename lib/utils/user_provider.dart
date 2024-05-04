// user_provider.dart

import 'package:eduapp/utils/user_model_baru.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  UserModelBaru? _userBaru;
  UserModelBaru? get userBaru => _userBaru;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

    void setUserBaru(UserModelBaru userBaru) {
    _userBaru = userBaru;
    notifyListeners();
  }
}