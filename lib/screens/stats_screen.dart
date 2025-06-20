import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction.dart';

class StatsScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const StatsScreen({super.key, required this.transactions});

  double getTotalIncome() {
    return transactions
        .where((tx) => tx.amount > 0)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double getTotalExpense() {
    return transactions
        .where((tx) => tx.amount < 0)
        .fold(0.0, (sum, tx) => sum + tx.amount.abs());
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = getTotalIncome();
    final totalExpense = getTotalExpense();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Keuangan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.arrow_upward, color: Colors.green),
                title: const Text('Pemasukan'),
                trailing: Text('Rp ${totalIncome.toStringAsFixed(0)}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.arrow_downward, color: Colors.red),
                title: const Text('Pengeluaran'),
                trailing: Text('Rp ${totalExpense.toStringAsFixed(0)}'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Diagram Pemasukan vs Pengeluaran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Pie Chart
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: totalIncome,
                      color: Colors.green,
                      title: 'Income',
                      titleStyle: const TextStyle(color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: totalExpense,
                      color: Colors.red,
                      title: 'Expense',
                      titleStyle: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
