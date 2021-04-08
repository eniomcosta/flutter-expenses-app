import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/extension/same_date.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final int daysToConsider;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(daysToConsider, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double daySum = 0.0;

      // total = recentTransactions
      //     .where((element) => element.date.isSameDate(weekDay))
      //     .fold(0.0, (previousValue, element) => element.value);

      for (var t in recentTransactions) {
        bool sameDay = t.date.day == weekDay.day;
        bool sameMonth = t.date.month == weekDay.month;
        bool sameYear = t.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          daySum += t.value;
        }
      }

      return {
        'day': DateFormat.E("pt_BR").format(weekDay),
        'value': daySum,
        'percentage': 50.0,
      };
    });
  }

  Chart({this.recentTransactions, this.daysToConsider});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((t) {
          return ChartBar(
            label: t['day'],
            value: t['value'],
            percentage: t['percentage'],
          );
        }).toList(),
      ),
    );
  }
}
