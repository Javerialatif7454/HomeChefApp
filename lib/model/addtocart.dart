class CartItem {
  final int? id;
  final String imagePath;
  final String title;
  final String price;
   int quantity;

  CartItem({
    this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    this.quantity=1,
  });

  // Convert a CartItem into a Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }
  CartItem increaseQuantity() {
    return CartItem(
      id: id,
      imagePath: imagePath,
      title: title,
      price: price,
      quantity: quantity + 1, // Increment the quantity
    );
  }
  CartItem decQuantity() {
    return CartItem(
      id: id,
      imagePath: imagePath,
      title: title,
      price: price,
      quantity: quantity - 1, // Increment the quantity
    );
  }
  CartItem copyWithQuantity(int newQuantity) {
    return CartItem(
      id: id,
      imagePath: imagePath,
      title: title,
      price: price,
      quantity: newQuantity,
    );
  }


  // Convert a Map into a CartItem
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      imagePath: map['imagePath'],
      title: map['title'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
