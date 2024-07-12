import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class History extends StatelessWidget {
  const History({super.key});
  @override
  Widget build(BuildContext context) {
    var num = DateTime.now().month - 1;
    if (num < 0){
      num = 12;
    }
    return Scaffold(
        body: Column(
            children: [Center(
              child: HeatMap(
                startDate: DateTime(2024, num%13, 3),
                endDate: DateTime.now(),
                datasets: {
                  DateTime(2024, 4, 9): 5,
                  DateTime(2024, 4, 12): 7,
                  DateTime(2024, 4, 13): 8,
                },
                colorMode: ColorMode.opacity,
                showText: true,
                scrollable: true,
                colorsets: {
                  1: Colors.lightGreenAccent,
                  3: Colors.orange,
                  5: Colors.yellow,
                  7: Colors.green,
                  9: Colors.blue,
                  11: Colors.indigo,
                  13: Colors.purple,
                },
                showColorTip: false,
                onClick: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
                },
                size: 40,
              ),
            ),]
        )
    );
  }
}