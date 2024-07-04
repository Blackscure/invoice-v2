import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionService transactionService = TransactionService();
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  void fetchTransactions() async {
    try {
      final fetchedTransactions = await transactionService.fetchTransactions();
      setState(() {
        transactions = fetchedTransactions;
      });
    } catch (e) {
      print('Failed to load transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(transaction.transactionId),
            subtitle: Text('Amount: \Kes${transaction.amount} - Status: ${transaction.status} - Phone: ${transaction.phoneNumber}'),
            trailing: Text(transaction.createdAt.toLocal().toString().split(' ')[0]),
          ),
        );
      },
    );
  }
}
