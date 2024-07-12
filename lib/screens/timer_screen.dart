import 'dart:async';
import 'package:fittness_1/screens/excercise_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class timer_screen extends StatefulWidget {
  final index;
  timer_screen({
    required this.index,
  });

  @override
  State<timer_screen> createState() => _timer_screenState();
}

class _timer_screenState extends State<timer_screen> {
  int countdown = 5;
  int? workOut = 0;
  bool today_done=false;
  late DateTime today_date_time;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkOut();
  }
  void _startcountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        today_done=true;
        today_date_time=DateTime.now();
        page_exercise.today_date=DateTime(today_date_time.year,today_date_time.month,today_date_time.day);
        timer.cancel();
      }
      ;
    });
  }

  void reset() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    setState(() {
      countdown = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Builder(builder: (context) {
          return IconButton(
            iconSize: 30,
            color: Colors.deepPurple.shade100,
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(95, 0, 0, 0),
          child: Text(
            "U-FIT",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade100),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircularProgressIndicator(
                    value: countdown / 5,
                    strokeWidth: 7,
                  ),
                ),
                Text(
                  countdown.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                if (countdown == 0) {
                  Navigator.pop(context);

                } else if (countdown == 5) {
                  _startcountdown();
                } else {
                  countdown = 5;
                  reset();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20), // Set the circular border radius here
              ),
              color: Colors.deepPurple,
              height: 40,
              child: Text(
                (countdown == 0)
                    ? "Done"
                    : (countdown == 5)
                        ? "Start"
                        : "Reset",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                page_exercise.exercise[widget.index],
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text("Sets: ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
                  Text(page_exercise.exercise_sets[widget.index],style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Column(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Description: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )),
                Text(
                  page_exercise.exercise_desc[widget.index],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ])),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text("Video Explanation: ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700)),
                  GestureDetector(
                    onTap: loadurl,
                    child: Text("Click Here!!",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadurl () async{
    var url=Uri.parse("https://www.youtube.com/watch?v=XxuRSjER3Qk");
    if( await canLaunchUrl(url)){
      try{
        await launchUrl(url);
      }catch(e){
        print(e.toString());
      }
    }else{
      print("Cannot load url");
    }
  }

  void getWorkOut() async{
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _timer;
    });
  }
}
