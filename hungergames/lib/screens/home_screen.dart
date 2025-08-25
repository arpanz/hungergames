import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../services/supabase_service.dart';
import '../widgets/category_tabs.dart';
import '../widgets/food_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodItem> _foodItems = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    final categories = await SupabaseService.getCategories();
    final foodItems = await SupabaseService.getFoodItems(
      category: _selectedCategory == 'All' ? null : _selectedCategory,
    );
    
    setState(() {
      _categories = categories;
      _foodItems = foodItems;
      _isLoading = false;
    });
  }

  Future<void> _onCategoryChanged(String category) async {
    setState(() {
      _selectedCategory = category;
      _isLoading = true;
    });
    
    final foodItems = await SupabaseService.getFoodItems(
      category: category == 'All' ? null : category,
    );
    
    setState(() {
      _foodItems = foodItems;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: Colors.orange,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'HungerSpace',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Late Night Cravings Delivered',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Category Tabs
          CategoryTabs(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategoryChanged: _onCategoryChanged,
          ),
          
          // Food Grid
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  )
                : FoodGrid(foodItems: _foodItems),
          ),
        ],
      ),
    );
  }
}
