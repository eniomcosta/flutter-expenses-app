import 'package:expenses/extension/same_date.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double total = 0.0;

      total = recentTransactions
          .where((element) => element.date.isSameDate(weekDay))
          .fold(0.0, (previousValue, element) => element.value);

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': total,
      };
    });
  }

  Chart({this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          for (var item in groupedTransactions.reversed)
            Column(
              children: [
                Text(item['value'].toString()),
                Text(item['day']),
              ],
            )
        ],
      ),
    );
  }
}
