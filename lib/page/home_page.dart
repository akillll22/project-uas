import 'package:flutter/material.dart';
import '../models/transaction.dart';

class HomePage extends StatelessWidget {
  final List<Transaction> transactions;
  final VoidCallback onViewStats;
  final VoidCallback onGoToAddTransaction;

  const HomePage({
    super.key,
    required this.transactions,
    required this.onViewStats,
    required this.onGoToAddTransaction,
  });

  double getTotalBalance() {
    return transactions.fold(0.0, (sum, tx) => sum + tx.amount);
  }

  @override
  Widget build(BuildContext context) {
    final totalBalance = getTotalBalance();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DompetKu'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Saldo
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Saldo Anda:', style: TextStyle(fontSize: 18)),
                    Text(
                      'Rp ${totalBalance.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Transaksi Terbaru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            // List Transaksi
            Expanded(
              child:
                  transactions.isEmpty
                      ? const Center(child: Text('Belum ada transaksi'))
                      : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(tx.icon, color: Colors.teal),
                              title: Text(tx.title),
                              subtitle: Text(
                                '${tx.category} • ${tx.date.day}/${tx.date.month}/${tx.date.year}',
                              ),
                              trailing: Text(
                                '${tx.amount < 0 ? '-' : '+'}Rp ${tx.amount.abs()}',
                                style: TextStyle(
                                  color:
                                      tx.amount < 0 ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 10),

            // Tombol Aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: onGoToAddTransaction,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
                ElevatedButton.icon(
                  onPressed: onViewStats,
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('Statistik'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
