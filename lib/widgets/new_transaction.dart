import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;
  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  DateTime dateChosen;

  void _submitData() {
    if (this.amountCtrl.text.isEmpty || this.titleCtrl.text.isEmpty) {
      return;
    }
    final enteredTitle = this.titleCtrl.text;
    final enteredAmount = double.parse(this.amountCtrl.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || this.dateChosen == null) {
      return;
    }
    this.widget.newTx(enteredTitle, enteredAmount, this.dateChosen);
    this.dateChosen = null;

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        this.dateChosen = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleCtrl,
                onSubmitted: (_) => this._submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => this._submitData(),
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(this.dateChosen == null
                          ? 'No Date Chosen'
                          : 'Picked date: ${DateFormat.yMMMMEEEEd().format(this.dateChosen)}'),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: this._presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: this._submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
