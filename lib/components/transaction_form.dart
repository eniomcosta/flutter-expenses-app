import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime selectedDate)
      onSubmit;

  TransactionForm({this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = MoneyMaskedTextController(
      decimalSeparator: ",", thousandSeparator: ".", leftSymbol: "R\$");

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text
        .replaceAll("R\$", "")
        .replaceAll(".", "")
        .replaceAll(",", "."));

    if (title.isEmpty || _selectedDate == null || value < 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now())
        .then((value) {
      setState(() => _selectedDate = value);
    });
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
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate != null
                        ? "Data selecionada: ${DateFormat("dd/MM/y").format(_selectedDate)}"
                        : "Nenhuma data selecionada"),
                  ),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: Text("Selecione uma data")),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _submitForm, child: Text('Nova Transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
