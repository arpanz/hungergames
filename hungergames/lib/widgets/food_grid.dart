import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'food_card.dart';

class FoodGrid extends StatelessWidget {
  final List<FoodItem> foodItems;

  const FoodGrid({super.key, required this.foodItems});

  @override
  Widget build(BuildContext context) {
    if (foodItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No items found',
              style: TextStyle(fontSize: 18, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),

      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return FoodCard(foodItem: foodItems[index]);
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 2; // Mobile
    if (width < 900) return 2; // Tablet
    if (width < 1200) return 3; // Small Desktop
    return 4; // Large Desktop
  }
}
