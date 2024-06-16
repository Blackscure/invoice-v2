// lib/home_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/invoice_model.dart';
import '../services/api_service.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Invoice> invoices = [];

  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  void fetchInvoices() async {
    final response = await apiService.retrieveInvoices();
    if (response.statusCode == 200) {
      final invoicesResponse = InvoicesResponse.fromJson(jsonDecode(response.body));
      setState(() {
        invoices = invoicesResponse.invoices;
      });
    }
  }

  void createInvoice(String invoiceNumber, double amount) async {
    final response = await apiService.createInvoice(invoiceNumber, amount);
    if (response.statusCode == 201) {
      fetchInvoices();
    }
  }

  void makePayment(String invoiceNumber) async {
    final response = await apiService.makePayment(invoiceNumber, '254704709515');
    if (response.statusCode == 200) {
      fetchInvoices();
    }
  }

  void showCreateInvoiceForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final _invoiceNumberController = TextEditingController();
        final _amountController = TextEditingController();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _invoiceNumberController,
                decoration: InputDecoration(labelText: 'Invoice Number'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final invoiceNumber = _invoiceNumberController.text;
                  final amount = double.tryParse(_amountController.text) ?? 0.0;
                  createInvoice(invoiceNumber, amount);
                  Navigator.pop(context);
                },
                child: Text('Create Invoice'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return ListTile(
            title: Text(invoice.invoiceNumber),
            subtitle: Text('Amount: \Kes${invoice.amount} - Status: ${invoice.status}'),
            trailing: IconButton(
              icon: Icon(Icons.payment),
              onPressed: () => makePayment(invoice.invoiceNumber),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateInvoiceForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
