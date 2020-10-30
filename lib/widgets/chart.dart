import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/widgets/chartbar.dart';
import '../models/trans.dart';

class Chart extends StatelessWidget {
  final List<Trans> recentTrans;
  Chart(this.recentTrans);

  List<Map<String, Object>> get groupTrans {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0;
      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalsum += recentTrans[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalsum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalspen {
    return groupTrans.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTrans);

    return Container(
        child: Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding (
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTrans.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: Chartbar(
                    data['day'],
                    data['amount'],
                    totalspen == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalspen));
          }).toList(),
        ),
      ),
    ));
  }
}
