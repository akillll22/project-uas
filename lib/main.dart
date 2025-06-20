import 'package:flutter/material.dart';
import 'page/home_page.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/stats_screen.dart';
import 'models/transaction.dart';

void main() {
  runApp(const DompetApp());
}

class DompetApp extends StatelessWidget {
  const DompetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DompetKu',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Transaction> _transactions = [];

  void _addTransaction(Transaction tx) {
    setState(() {
      _transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(
        transactions: _transactions,
        onViewStats: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StatsScreen(transactions: _transactions),
            ),
          );
        },
        onGoToAddTransaction: () async {
          final newTx = await Navigator.push<Transaction>(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );

          if (newTx != null) {
            _addTransaction(newTx);
          }
        },
      ),
    );
  }
}
