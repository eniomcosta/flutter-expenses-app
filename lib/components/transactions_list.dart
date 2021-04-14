import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  _noTransactions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Nenhuma transação cadastrada",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? _noTransactions(context)
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final t = transactions[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text("R\$${t.value}"),
                          ),
                        ),
                      ),
                      title: Text(
                        "${t.title}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat("d MMM y").format(t.date),
                      ),
                    ),
                  );
                }));
  }
}
