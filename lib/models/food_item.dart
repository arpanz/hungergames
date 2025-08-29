// lib/models/food_item.dart - UPDATED
class FoodItem {
  final int id;
  final String name;
  final String category;
  final String imageUrl;
  final int? price; // Now nullable
  final int originalPrice;
  final int quantityAvailable;
  final int ranking; // New field for sorting

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    this.price, // Now nullable
    required this.originalPrice,
    required this.quantityAvailable,
    required this.ranking, // Add to constructor
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
      ranking: json['ranking'] as int, // Parse from JSON
    );
  }

  // Updated getters to handle nullable price
  bool get isOnSale => price != null && price! < originalPrice;
  bool get isInStock => quantityAvailable > 0;

  // Get the actual selling price (price if available, otherwise original_price)
  int get sellingPrice => price ?? originalPrice;
}