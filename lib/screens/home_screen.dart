import 'package:flutter/material.dart';
import '../models/invoice_model.dart';
import '../services/invoice_service.dart';
import '../utils/dialog_helpers.dart';  // Import the dialog helpers

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InvoiceService invoiceService = InvoiceService();
  List<Invoice> invoices = [];

  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  void fetchInvoices() async {
    final fetchedInvoices = await invoiceService.fetchInvoices();
    setState(() {
      invoices = fetchedInvoices;
    });
  }

  void createInvoice(String invoiceNumber, double amount) async {
    await invoiceService.createInvoice(invoiceNumber, amount);
    fetchInvoices();
  }

  void makePayment(String invoiceNumber) async {
    await invoiceService.makePayment(invoiceNumber);
    fetchInvoices();
  }

  void showCreateInvoiceFormDialog() {
    showCreateInvoiceForm(context, createInvoice);  // Call the helper function
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
          return Card(
            elevation: 4, // Adjust the elevation for the shadow
            shadowColor: Colors.black, // Set shadow color to black
            margin: EdgeInsets.all(8), // Add margin for spacing between cards
            child: ListTile(
              title: Text(invoice.invoiceNumber),
              subtitle: Text('Amount: \Kes${invoice.amount} - Status: ${invoice.status}'),
              trailing: IconButton(
                icon: Icon(Icons.payment),
                onPressed: () => makePayment(invoice.invoiceNumber),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateInvoiceFormDialog,  // Call the renamed method
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateInvoiceForm extends StatefulWidget {
  final Function(String, double) onSubmit;

  CreateInvoiceForm({required this.onSubmit});

  @override
  _CreateInvoiceFormState createState() => _CreateInvoiceFormState();
}

class _CreateInvoiceFormState extends State<CreateInvoiceForm> {
  final TextEditingController _invoiceNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _invoiceNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _invoiceNumberController,
            decoration: InputDecoration(
              labelText: 'Invoice Number',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final invoiceNumber = _invoiceNumberController.text;
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              widget.onSubmit(invoiceNumber, amount);
              Navigator.pop(context); // Close the modal after submission
            },
            child: Text('Create Invoice'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
