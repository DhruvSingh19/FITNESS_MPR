import 'dart:convert';
import 'package:fittness_1/utils/timeline_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class excercise_page extends StatefulWidget {
  final String getmuscle;
  final int ind;
  final int difficulty;
  excercise_page({required this.getmuscle,required this.ind,required this.difficulty});

  @override
  State<StatefulWidget> createState() {
    return page_exercise();
  }
}


class page_exercise extends State<excercise_page> {
  static List<String> exercise=[];
  static List<String> exercise_desc=[];
  static List<String> exercise_sets=[];
  static List<String> exercise_link=[];
  static late DateTime today_date ;
  static late bool today_done;
  String difficulty_use="";
  Future apicall(String muscle) async {
    const apiKey = '5534b5afd6msh6126aecd814351dp140b30jsn658e5cc38ad3';
    const u = 'https://work-out-api1.p.rapidapi.com/search?';
    final url = '$u?Muscles=$muscle';
    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'work-out-api1.p.rapidapi.com',
    };

    try {
      exercise.clear();
      exercise_desc.clear();
      exercise_sets.clear();
      exercise_link.clear();
      switch(widget.difficulty){
        case 0:
          difficulty_use="Beginner";
          break;
        case 1:
          difficulty_use="Intermediate";
          break;
        case 2:
          difficulty_use="Expert";
          break;
      }
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body) as List<dynamic>;
        final filteredData = decodedData.where((workout) =>
        workout['Muscles']?.toLowerCase() == muscle.toLowerCase()).toList();
        if (difficulty_use == "Beginner") {
          for (var muscle in filteredData) {
            if (muscle['Intensity_Level'].toString() == difficulty_use) {
              exercise.add(muscle['WorkOut']);
              exercise_desc.add(muscle['Long Explanation']);
              exercise_sets.add(muscle[difficulty_use+" Sets"]);
              exercise_link.add(muscle['Video']);
            }
          }
        }
        else if (difficulty_use == "Intermediate") {
          for (var muscle in filteredData) {
            if (muscle['Intensity_Level'].toString() == difficulty_use) {
              exercise.add(muscle['WorkOut']);
              exercise_desc.add(muscle['Long Explanation']);
              exercise_sets.add(muscle[difficulty_use+" Sets"]);
              exercise_link.add(muscle['Video']);
            }
          }
          for (var muscle in filteredData) {
            if (muscle['Intensity_Level'].toString() == "Beginner") {
              exercise.add(muscle['WorkOut']);
              exercise_desc.add(muscle['Long Explanation']);
              exercise_sets.add(muscle[difficulty_use+" Sets"]);
              exercise_link.add(muscle['Video']);
            }
          }
        }
        else {
          for (var muscle in filteredData) {
            exercise.add(muscle['WorkOut']);
            exercise_desc.add(muscle['Long Explanation']);
            exercise_sets.add(muscle[difficulty_use+" Sets"]);
            exercise_link.add(muscle['Video']);
          }
        }
      }
      else{
        print("API call failed with status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error occurred: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    int use,curr=0;
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
      Padding(
        padding: const EdgeInsets.fromLTRB(50.0,10,0,0),
        child: FutureBuilder(
          future: apicall(widget.getmuscle),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If there's an error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // If data is successfully loaded
              return ListView.builder(
                itemBuilder: (context, index) {
                  return mytimeline_tile(
                    isFirst: (index == 0) ? true : false,
                    isLast: (index == exercise.length -1) ? true : false,
                    isPast: (index>2)?false:true,
                    index: index,
                  );
                },
                itemCount: exercise.length,
              );
            }
          },
        )
      )
    );
  }
}
