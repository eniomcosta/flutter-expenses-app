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

      //double daySum = 0.0;

      double daySum = recentTransactions
          .where((element) => element.date.isSameDate(weekDay))
          .fold(0.0, (previousValue, element) => element.value);

      // for (var t in recentTransactions) {
      //   bool sameDay = t.date.day == weekDay.day;
      //   bool sameMonth = t.date.month == weekDay.month;
      //   bool sameYear = t.date.year == weekDay.year;

      //   if (sameDay && sameMonth && sameYear) {
      //     daySum += t.value;
      //   }
      // }

      return {
        'day': DateFormat.E("pt_BR").format(weekDay),
        'value': daySum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (previousValue, element) => previousValue + element['value']);
  }

  Chart({this.recentTransactions, this.daysToConsider});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((t) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: t['day'],
                value: t['value'],
                percentage: _weekTotalValue == 0
                    ? 0
                    : ((t['value'] as double) / _weekTotalValue) * 100,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
