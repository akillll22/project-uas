import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedCategory = 'Makanan';
  DateTime? _selectedDate;

  final List<String> _categories = [
    'Makanan',
    'Transportasi',
    'Hiburan',
    'Belanja',
    'Beasiswa',
    'Lainnya',
  ];

  void _submitTransaction() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    final date = _selectedDate;

    if (title.isEmpty || amount == null || date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi dengan benar')),
      );
      return;
    }

    final newTx = Transaction(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      category: _selectedCategory,
      date: date,
    );

    Navigator.pop(
      context,
      newTx,
    ); // ← Kirim transaksi balik ke halaman sebelumnya
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: _selectedCategory,
                items:
                    _categories
                        .map(
                          (cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Tanggal belum dipilih'
                          : 'Tanggal: ${DateFormat.yMMMd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTransaction,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text('Simpan Transaksi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
