import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/transaction.dart';
import 'page/home_page.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/stats_screen.dart';
import 'storage/transaction_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

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
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _storage = TransactionStorage();
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _transactions = _storage.getAllTransactions();
  }

  void _addTransaction(Transaction tx) async {
    await _storage.addTransaction(tx);
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
