import 'dart:math';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transactions_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            button:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  final _daysToConsider = 7;

  final List<Transaction> _transactions = [
    Transaction(
        id: "t0",
        date: DateTime.now().subtract(Duration(days: 33)),
        title: "Conta do mês passado",
        value: 100.00),
    Transaction(
        id: "t1",
        date: DateTime.now().subtract(Duration(days: 1)),
        title: "Novo Tênis de Corrida",
        value: 310.76),
    Transaction(
        id: "t2",
        date: DateTime.now().subtract(Duration(days: 2)),
        title: "Conta #01",
        value: 1211.13),
    Transaction(
        id: "t3", date: DateTime.now(), title: "Conta #02", value: 211.13),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((t) => t.date
            .isAfter(DateTime.now().subtract(Duration(days: _daysToConsider))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction = new Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: selectedDate);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(
            onSubmit: _addTransaction,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
                recentTransactions: _recentTransactions,
                daysToConsider: _daysToConsider),
            TransactionList(
              transactions: _transactions,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
