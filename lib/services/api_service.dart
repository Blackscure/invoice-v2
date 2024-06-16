import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<http.Response> createInvoice(String invoiceNumber, double amount) {
    final url = Uri.parse('$baseUrl/invoices');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'invoice_number': invoiceNumber, 'amount': amount}),
    );
  }

  Future<http.Response> makePayment(String invoiceNumber, String phoneNumber) {
    final url = Uri.parse('$baseUrl/pay/$invoiceNumber');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );
  }

  Future<http.Response> retrieveInvoices() {
    final url = Uri.parse('$baseUrl/retrive-invoices');
    return http.get(url);
  }
}
