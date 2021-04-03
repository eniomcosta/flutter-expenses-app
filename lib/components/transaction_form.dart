import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value) onSubmit;

  TransactionForm({this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = MoneyMaskedTextController(
      decimalSeparator: ",", thousandSeparator: ".", leftSymbol: "R\$");

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text
        .replaceAll("R\$", "")
        .replaceAll(".", "")
        .replaceAll(",", "."));

    if (title.isEmpty) {
      return;
    }

    widget.onSubmit(title, value);
  }

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
              onSubmitted: (_) => _submitForm(),
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor'),
              controller: _valueController,
              onFieldSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(primary: Colors.purple),
                    onPressed: _submitForm,
                    child: Text('Nova Transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
