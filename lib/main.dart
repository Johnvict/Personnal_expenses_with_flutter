import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';  // ! For restricting app on certain orientation
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';
import './widgets/Chart.dart';

void main() => runApp(MyApp());
// void main() {
//     SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//     ]);
//     runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.red,
        fontFamily: 'Merriweather',
        textTheme: ThemeData.dark().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.red),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.black,
        fontFamily: 'Merriweather',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
      amount: 78.90,
      date: DateTime.now(),
      title: 'First trans',
      id: 'id1',
    ),
    Transaction(
      amount: 218.67,
      date: DateTime.now(),
      title: 'New bag',
      id: 'id2',
    ),
  ];

  List<Transaction> get _recentTransactions {
    return this.transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      amount: txAmount,
      title: txTitle,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      this.transactions.add(newTx);
    });
  }

  void _removeTransaction(int index) {
    setState(() {
      this.transactions.removeAt(index);
      // this.transactions.removeWhere((tx) => tx.id === id);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Fashion'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => this.startNewTransaction(context),
          tooltip: 'new transaction',
          splashColor: Theme.of(context).primaryColorLight,
        )
      ],
    );

    final Widget chart = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (isLandScape ? 0.5 : 0.3),
      width: mediaQuery.size.width * (isLandScape ? 0.4 : 1),
      child: Chart(this._recentTransactions),
    );

    final Widget translist = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (isLandScape ? 1 : 0.7),
      width: mediaQuery.size.width * (isLandScape ? 0.6 : 1),
      child: TransactionList(this.transactions, this._removeTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: isLandScape
              ? Row(
                  //   crossAxisAlignment: CrossAxisAlignment.,
                  children: <Widget>[
                    translist,
                    chart,
                  ],
                )
              : Column(
                  children: <Widget>[
                    chart,
                    translist,
                  ],
                )),
      floatingActionButtonLocation: isLandScape
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => this.startNewTransaction(context),
        tooltip: 'New transaction',
        child: Icon(Icons.add),
      ),
    );
  }
}