import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './../models/transactions.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required Transaction userTransaction,
    @required this.deleteTransaction,
    @required this.index,
  })  : userTransaction = userTransaction,
        super(key: key);

  final Transaction userTransaction;
  final num index;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
// return Card(
    //   child: Row(
    //     children: <Widget>[
    //       Container(
    //         margin: EdgeInsets.symmetric(
    //           vertical: 10,
    //           horizontal: 15,
    //         ),
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: Theme.of(context).primaryColor,
    //             width: 2,
    //           ),
    //         ),
    //         padding: EdgeInsets.all(10),
    //         child: Text(
    //           '\$${this.userTransaction.amount.toStringAsFixed(2)}',
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //             color: Theme.of(context).primaryColorDark,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             this.userTransaction.title,
    //             style: Theme.of(context).textTheme.title,
    //           ),
    //           Text(
    //             DateFormat.yMMMMEEEEd()
    //                 .format(this.userTransaction.date),
    //             style: TextStyle(
    //               color: Colors.grey,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        // leading: Container(
        //     height: 60,
        //     width: 60,
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Theme.of(context).primaryColor
        //     ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          // foregroundColor: Colors.white,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              '\$${this.userTransaction.amount}',
              style: TextStyle(
                fontFamily: 'Merriweather',
                // fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            )),
          ),
        ),
        title: Text(
          this.userTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd().format(this.userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () => this.deleteTransaction(index),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => this.deleteTransaction(index),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
