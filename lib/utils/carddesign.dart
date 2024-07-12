import 'package:fittness_1/screens/excercise_page.dart';
import 'package:fittness_1/screens/timer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class carddesign extends StatelessWidget{
  final index;
  final isPast;
  carddesign({
    required this.index,
    required this.isPast
});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0,0,10,0),
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: isPast?Colors.deepPurple:Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(page_exercise.exercise[index],style: TextStyle(
                      color: Colors.white,fontSize: 22
                    ),),
                  ),
                ),
            ),
          ),
        GestureDetector(
          onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context)=>timer_screen(index: index,)));},
          child: Container(
            child: Icon(Icons.navigate_next),
          ),
        ),
      ],
    );
  }

}