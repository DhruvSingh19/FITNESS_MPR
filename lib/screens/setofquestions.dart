import 'package:fittness_1/screens/home_screen.dart';
import 'package:fittness_1/utils/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class setofquestions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return setofquestions_screen();
  }
}

class setofquestions_screen extends State<setofquestions>{
  final TextEditingController name = TextEditingController();
  //final TextEditingController age = TextEditingController();
  int? age ;
  String? gender ;
  double? height ;
  //final TextEditingController height = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Fill the details!!",
              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),

            Padding(
              padding: const EdgeInsets.fromLTRB(40.0,40.0,40.0,0),
              child: CustomTextField(controller: name,
                  hintText: 'Enter your name',
              ),
            ),

            SizedBox(
              height: 20,
            ),

            DropdownButton(
              hint: Text("Select your age",style: TextStyle(color: Colors.white),),
                value: age,
                items: [DropdownMenuItem(child: Text("15"),value: 15,),
                  DropdownMenuItem(child: Text("16"),value: 16,),
                  DropdownMenuItem(child: Text("17"),value: 17,),
                  DropdownMenuItem(child: Text("18"),value: 18,),
                  DropdownMenuItem(child: Text("19"),value: 19,),
                  DropdownMenuItem(child: Text("20"),value: 20,),
                  DropdownMenuItem(child: Text("21"),value: 21,),
                  DropdownMenuItem(child: Text("22"),value: 22),
                  DropdownMenuItem(child: Text("23"),value: 23,),
                  DropdownMenuItem(child: Text("24"),value: 24,),
                  DropdownMenuItem(child: Text("25"),value: 25,),
                ],
                onChanged: (int? newvalue){
                  setState(() {
                    age = newvalue;
                  });
                }),

            SizedBox(
              height: 20,
            ),

            DropdownButton(
                hint: Text("Select your gender",style: TextStyle(color: Colors.white)),
                value: gender,
                items: [DropdownMenuItem<String>(child: Text("Male"),value: 'Male',),
                  DropdownMenuItem<String>(child: Text("Female"),value: "Female",),
                  DropdownMenuItem<String>(child: Text("Transgender"),value: "Transgender",),
                ],
                onChanged: (String? newvalue){
                  setState(() {
                    gender = newvalue;
                  });
                }),

            SizedBox(
              height: 20,
            ),

            DropdownButton(
              hint: Text("Select your height",style: TextStyle(color: Colors.white)),
              value: height,
              items: [
                DropdownMenuItem(child: Text("15"), value: 15.0),
                DropdownMenuItem(child: Text("16"), value: 16.0),
                DropdownMenuItem(child: Text("17"), value: 17.0),
                DropdownMenuItem(child: Text("18"), value: 18.0),
                DropdownMenuItem(child: Text("19"), value: 19.0),
                DropdownMenuItem(child: Text("20"), value: 20.0),
                DropdownMenuItem(child: Text("21"), value: 21.0),
                DropdownMenuItem(child: Text("22"), value: 22.0),
                DropdownMenuItem(child: Text("23"), value: 23.0),
                DropdownMenuItem(child: Text("24"), value: 24.0),
                DropdownMenuItem(child: Text("25"), value: 25.0),
              ],
              onChanged: (double? newValue) {
                setState(() {
                  height = newValue;
                });
              },
            ),

            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: ()async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setBool('isfirsttimelogin', false);
                pref.setString('name', name.text);
                pref.setString('age', age.toString());
                pref.setString('gender', gender.toString());
                pref.setString('height', height.toString());
                pref.setInt('workout', 0);
                pref.setInt('kcal', 0);
                pref.setInt('minute', 0);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
              child: Text("Continue",style: TextStyle(color: Colors.black,fontSize: 20)),
            ),


            SizedBox(
              height: 20,
            ),


           // ElevatedButton(
           //    onPressed: ()async {
           //      if(age==null||gender==null||height==null){
           //        SnackBar(content: Text("Please enter all fields!!"),
           //        );
           //      }
           //      else {
           //        SharedPreferences pref = await SharedPreferences.getInstance();
           //        pref.setBool('isfirsttimelogin', true);
           //        pref.setString('name', name.text);
           //        pref.setString('age', age.toString());
           //        pref.setString('gender', gender.toString());
           //        pref.setString('height', height.toString());
           //        Navigator.push(context,
           //            MaterialPageRoute(builder: (context) => HomeScreen()));
           //      }
           //      },
           //    child: Text("continuetrue"),
           //  ),
          ],
        ),
      ),
    );
  }

}