import 'package:fittness_1/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settings_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return settingsscreenstate();
  }
}

void signoutuser(BuildContext context){
  authservice().signout(context);
}

class settingsscreenstate extends State<settings_screen>{
var name,age,height,gender;
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }
_loadSettings() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  setState(() {
    name = pref.getString('name') ?? 'Unknown';
    age = pref.getString('age') ?? 'Unknown';
    gender = pref.getString('gender') ?? 'Unknown';
    height = pref.getString('height') ?? 'Unknown';
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:
     Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Text("hello"),
         Text(name),
         Text(age),
         Text(gender),
         Text(height),
         ElevatedButton(
             onPressed: () {
            signoutuser(context);
    }
         , child: Text("logout"))
       ],
     ) ,
    );
  }

}