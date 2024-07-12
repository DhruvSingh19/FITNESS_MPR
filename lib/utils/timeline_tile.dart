import 'package:fittness_1/utils/carddesign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class mytimeline_tile extends StatelessWidget{
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final int index;
  mytimeline_tile({
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.index,
});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(isFirst: isFirst, isLast: isLast,
        beforeLineStyle: LineStyle(color: isPast? Colors.deepPurple:Colors.deepPurple.shade100),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast?Colors.deepPurple:Colors.deepPurple.shade100,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: isPast? Colors.white:Colors.deepPurple
          )
        ),
        endChild: carddesign(index:index,isPast: isPast),
      ),
    );
  }

}