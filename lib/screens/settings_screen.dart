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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Builder(
            builder: (context) {
              return IconButton(
                iconSize: 30,
                color: Colors.deepPurple.shade100,
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
          child: Text("U-FIT",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.deepPurple.shade100),),
        ),
      ),
     body:
     Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Text("SIGN OUT"),
           Text(name +" "+ age, style: const TextStyle(fontWeight: FontWeight.bold)),
           ElevatedButton(
               onPressed: () {
              signoutuser(context);
           }
           , child: Text("logout"))
         ],
       ),
     ) ,
    );
  }

}