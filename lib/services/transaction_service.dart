import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction_model.dart';

class TransactionService {
  final String baseUrl = 'http://10.0.2.2:8000/api/transactions';

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Transaction> transactions = body.map((dynamic item) => Transaction.fromJson(item)).toList();
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}
