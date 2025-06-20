import 'package:hive/hive.dart';
import '../models/transaction.dart';

class TransactionStorage {
  static const String boxName = 'transactions';

  /// Menyimpan transaksi baru ke Hive
  Future<void> addTransaction(Transaction tx) async {
    final box = Hive.box<Transaction>(boxName);
    await box.put(tx.id, tx); // pakai id sebagai key
  }

  /// Menghapus transaksi berdasarkan ID
  Future<void> deleteTransaction(String id) async {
    final box = Hive.box<Transaction>(boxName);
    await box.delete(id);
  }

  /// Mengambil semua transaksi dari Hive
  List<Transaction> getAllTransactions() {
    final box = Hive.box<Transaction>(boxName);
    return box.values.toList();
  }

  /// Menghapus semua transaksi
  Future<void> clearAll() async {
    final box = Hive.box<Transaction>(boxName);
    await box.clear();
  }
}
