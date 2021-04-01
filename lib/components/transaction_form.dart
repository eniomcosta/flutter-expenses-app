import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  final void Function(String title, double value) onSubmit;

  TransactionForm({this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              controller: _valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(primary: Colors.purple),
                    onPressed: () {
                      final title = _titleController.text;
                      final value = double.tryParse(
                              _valueController.text.replaceAll(",", ".")) ??
                          0;
                      onSubmit(title, value);
                    },
                    child: Text('Nova Transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
