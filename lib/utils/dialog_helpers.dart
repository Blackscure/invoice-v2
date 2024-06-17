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
      bool isLoading = false; // Track loading state

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void handleSubmit() async {
            if (isLoading) return; // Prevent multiple submissions

            setState(() {
              isLoading = true; // Start loading
            });

            final phoneNumber = phoneNumberController.text;
            try {
              await onSubmit(invoiceNumber, phoneNumber);
              Navigator.of(context).pop(); // Close the dialog after successful submission
            } finally {
              setState(() {
                isLoading = false; // Stop loading
              });
            }
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Make Payment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Invoice Number: $invoiceNumber',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '254712345678',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: isLoading ? null : handleSubmit,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}




