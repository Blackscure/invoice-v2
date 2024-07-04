class Transaction {
  final int id;
  final int invoiceId;
  final String transactionId;
  final String phoneNumber;
  final double amount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.invoiceId,
    required this.transactionId,
    required this.phoneNumber,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      invoiceId: json['invoice_id'],
      transactionId: json['transaction_id'],
      phoneNumber: json['phone_number'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
