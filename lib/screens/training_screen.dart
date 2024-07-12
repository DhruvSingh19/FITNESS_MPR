import 'package:fittness_1/histroy.dart';
import 'package:flutter/material.dart';

class training_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return trainingscreenstate();
  }

}

class trainingscreenstate extends State<training_screen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: History()
    );
  }
}