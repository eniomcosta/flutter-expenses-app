import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(Transaction selectedTransaction) onDelete;

  TransactionList({this.transactions, this.onDelete});

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

  _openRemoveTransactionConfirmation(
      BuildContext context, Transaction selectedTransaction) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Confirmação"),
            content: Text("Deseja realmente remover?"),
            actions: [
              TextButton(
                  onPressed: () {
                    onDelete(selectedTransaction);
                    Navigator.of(context).pop();
                  },
                  child: Text("Sim")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Não")),
            ],
          );
        });
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
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () =>
                            _openRemoveTransactionConfirmation(context, t),
                      ),
                    ),
                  );
                }));
  }
}
