class FoodItem {
  final int id;
  final String name;
  final String category;
  final String imagePath;
  final int price;
  final int originalPrice;
  final int quantityAvailable;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.price,
    required this.originalPrice,
    required this.quantityAvailable,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      imagePath: json['image_path'] as String,
      price: json['price'] as int,
      originalPrice: json['original_price'] as int,
      quantityAvailable: json['quantity_available'] as int,
    );
  }

  bool get isOnSale => originalPrice > price;
  bool get isInStock => quantityAvailable > 0;
  
  String get whatsappMessage {
    return "Hi HungerSpace! I want to order *$name* - ₹$price. Is it available?";
  }
}
