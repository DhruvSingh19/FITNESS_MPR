import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class progress_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return progressscreenstate();
  }

}

class progressscreenstate extends State<progress_screen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<DataClass, int>>[
              LineSeries<DataClass, int>(
                  dataSource: <DataClass>[
                    DataClass(day: 9, calories_burned: 5),
                    DataClass(day: 12, calories_burned: 7),
                    DataClass(day: 13, calories_burned: 8),
                  ],
                  xValueMapper: (DataClass data, _) => data.day,
                  yValueMapper: (DataClass data, _) => data.calories_burned)
            ],
          )),
    );

  }
}

class DataClass {
  final int day;
  final int calories_burned;
  DataClass({required this.day, required this.calories_burned});
}