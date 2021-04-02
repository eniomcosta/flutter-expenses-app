import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: "t1",
        date: DateTime.now(),
        title: "Novo Tênis de Corrida",
        value: 310.76),
    Transaction(
        id: "t2", date: DateTime.now(), title: "Conta de #01", value: 1211.13),
    Transaction(
        id: "t3", date: DateTime.now(), title: "Conta de #02", value: 211.13),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = new Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(
          onSubmit: _addTransaction,
        ),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}
