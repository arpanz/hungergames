// lib/screens/home_screen.dart - UPDATED
import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/operational_hours.dart'; // Import new model
import '../services/supabase_service.dart';
import '../widgets/category_tabs.dart';
import '../widgets/food_grid.dart';
import '../widgets/operational_hours_bar.dart'; // Import new widget

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
  OperationalHours? _operationalHours; // Add this

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final categories = await SupabaseService.getCategories();
    final foodItems = await SupabaseService.getFoodItems(
      category: _selectedCategory == 'All' ? null : _selectedCategory,
    );
    final operationalHours =
        await SupabaseService.getOperationalHours(); // Fetch hours

    if (!mounted) return;
    setState(() {
      _categories = categories;
      _foodItems = foodItems;
      _operationalHours = operationalHours; // Set hours
      _isLoading = false;
    });
  }

  Future<void> _onCategoryChanged(String category) async {
    if (!mounted) return;
    setState(() {
      _selectedCategory = category;
      _isLoading = true;
    });

    final foodItems = await SupabaseService.getFoodItems(
      category: category == 'All' ? null : category,
    );

    if (!mounted) return;
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
                      Icon(Icons.restaurant, color: Colors.orange, size: 32),
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
                    'Night Cravings Done @4E-129/132',
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

          // Operational Hours Bar
          OperationalHoursBar(operationalHours: _operationalHours),

          // Category Tabs
          CategoryTabs(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategoryChanged: _onCategoryChanged,
          ),

          // Food Grid with Pull-to-Refresh
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  )
                : RefreshIndicator(
                    onRefresh: _loadData,
                    color: Colors.orange,
                    backgroundColor: Colors.grey[900],
                    child: FoodGrid(foodItems: _foodItems),
                  ),
          ),
        ],
      ),
    );
  }
}
