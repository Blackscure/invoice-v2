class Invoice {
  final int id;
  final String invoiceNumber;
  final double amount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class InvoicesResponse {
  final String message;
  final List<Invoice> invoices;

  InvoicesResponse({
    required this.message,
    required this.invoices,
  });

  factory InvoicesResponse.fromJson(Map<String, dynamic> json) {
    var invoicesList = json['invoices'] as List;
    List<Invoice> invoices = invoicesList.map((i) => Invoice.fromJson(i)).toList();

    return InvoicesResponse(
      message: json['message'],
      invoices: invoices,
    );
  }
}
