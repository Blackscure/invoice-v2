import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Import the necessary screens or widgets

void showCreateInvoiceForm(BuildContext context, Function(String, double) onSubmit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Invoice'),
        content: CreateInvoiceForm(onSubmit: onSubmit),
      );
    },
  );
}

void showPaymentDialog(BuildContext context, String invoiceNumber, Function(String, String) onSubmit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController phoneNumberController = TextEditingController();

      return AlertDialog(
        title: Text('Make Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Invoice Number: $invoiceNumber'),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final phoneNumber = phoneNumberController.text;
              onSubmit(invoiceNumber, phoneNumber);
              Navigator.pop(context);
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}


