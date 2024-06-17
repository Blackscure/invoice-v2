import 'dart:convert';
import '../models/invoice_model.dart';
import 'api_service.dart';

class InvoiceService {
  final ApiService apiService = ApiService();

  Future<List<Invoice>> fetchInvoices() async {
    final response = await apiService.retrieveInvoices();
    if (response.statusCode == 200) {
      final invoicesResponse = InvoicesResponse.fromJson(jsonDecode(response.body));
      return invoicesResponse.invoices;
    } else {
      // Handle error or return empty list
      return [];
    }
  }

  Future<void> createInvoice(String invoiceNumber, double amount) async {
    final response = await apiService.createInvoice(invoiceNumber, amount);
    if (response.statusCode == 201) {
      // Invoice created successfully
    } else {
      // Handle error
    }
  }

  Future<void> makePayment(String invoiceNumber) async {
    final response = await apiService.makePayment(invoiceNumber, '254704709515');
    if (response.statusCode == 200) {
      // Payment made successfully
    } else {
      // Handle error
    }
  }
}
