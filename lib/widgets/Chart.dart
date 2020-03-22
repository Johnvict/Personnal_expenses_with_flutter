import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './../models/transactions.dart';
import './Chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < this.recentTransactions.length; i++) {
        if (this.recentTransactions[i].date.day == weekday.day &&
            this.recentTransactions[i].date.month == weekday.month &&
            this.recentTransactions[i].date.year == weekday.year) {
          totalSum += this.recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();

    // list = list.sort((a, b) {
    //   return a['day'].toString().substring(0) == b['day'].toString().substring(0) ? 1 : -1;
    // });
  }

  double get totalSpending {
    return this.groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //   print(this.groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: this.groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
