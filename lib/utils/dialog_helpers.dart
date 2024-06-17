import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Import your home screen file

void showCreateInvoiceForm(BuildContext context, Function(String, double) onSubmit) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets, // Adjusts for the keyboard
        child: CreateInvoiceForm(onSubmit: onSubmit),
      );
    },
  );
}
