import 'package:fittness_1/Usermodel.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(id: '', name: '', email: '', password: '', token: '');

  User get user => _user;

  void setUser(String user){
    _user = User.formJson(user);
    notifyListeners();
  }

  void setUserformModel(User user){
    _user=user;
    notifyListeners();
  }
}