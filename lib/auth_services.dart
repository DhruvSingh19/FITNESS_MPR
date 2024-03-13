import 'dart:convert';
import 'package:fittness_1/screens/home_screen.dart';
import 'package:fittness_1/screens/signup_screen.dart';
import 'package:fittness_1/user_provider.dart';
import 'package:fittness_1/utils/constants.dart';
import 'package:fittness_1/utils/utils.dart';
import 'package:fittness_1/Usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authservice {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(id: '',
          name: name,
          email: email,
          password: password,
          token: '');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charaset=utf-8'
        },
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(
          context, "Account created! Login with the same credentials!",);
      });
    }
    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String name,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        body: jsonEncode({
          'name': name,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charaset=utf-8',
        },
      );

      httpErrorHandle(response: res, context: context,
          onSuccess: () async {
            SharedPreferences sp = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await sp.setString('x-auth-token', jsonDecode(res.body)['token']);
            navigator.pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) => HomeScreen()
            ),
                  (route) => false,
            );
          },
      );
    }

    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('x-auth-token');
      if (token == Null) {
        sp.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.uri}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charaset=utf-8',
          'x-auth-token': token!,
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${Constants.uri}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charaset=utf-8',
            'x-auth-token': token,
          },
        );
        userProvider.setUser(userRes.body);
      }
    }
    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signout(BuildContext context) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    SharedPreferences pref=await SharedPreferences.getInstance();
    sp.setString('x-auth-token', '');
    pref.setBool('isfirsttimelogin',true);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>SignupScreen()), (route) => false);
}
}
