class Order {
  final int? id;
  final String items;
  final double totalPrice;
  final String date;

  Order({
    this.id,
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  // Convert Order to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'items': items,
      'totalPrice': totalPrice,
      'date': date,
    };
  }
}
