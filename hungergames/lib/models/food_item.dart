// lib/models/food_item.dart - UPDATE THIS
class FoodItem {
  final int id;
  final String name;
  final String category;
  final String imageUrl;
  final int? price; // Now nullable
  final int originalPrice;
  final int quantityAvailable;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    this.price, // Now nullable
    required this.originalPrice,
    required this.quantityAvailable,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String,
      price: json['price'] as int?, // Handle nullable price
      originalPrice: json['original_price'] as int,
      quantityAvailable: json['quantity_available'] as int,
    );
  }

  // Updated getters to handle nullable price
  bool get isOnSale => price != null && price! < originalPrice;
  bool get isInStock => quantityAvailable > 0;
  
  // Get the actual selling price (price if available, otherwise original_price)
  int get sellingPrice => price ?? originalPrice;
}
