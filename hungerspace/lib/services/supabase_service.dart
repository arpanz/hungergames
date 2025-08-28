import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/food_item.dart';
import '../models/operational_hours.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://eoagacckvnaxuplabcjl.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvYWdhY2Nrdm5heHVwbGFiY2psIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxMTA3MjAsImV4cCI6MjA3MTY4NjcyMH0.k4PsYEStr_qbmJLHDpX2r9DzbxtzhcOToFcvQL3tAkc';

  static SupabaseClient? _client;

  static SupabaseClient get client {
    _client ??= SupabaseClient(supabaseUrl, supabaseAnonKey);
    return _client!;
  }

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static Future<List<FoodItem>> getFoodItems({String? category}) async {
    try {
      var query = client.from('food_items').select();

      if (category != null && category != 'All') {
        query = query.eq('category', category.toLowerCase());
      }

      // Sort by ranking ascending (starting from 1), then by name
      final response = await query
          .order('ranking', ascending: true)
          .order('name', ascending: true);

      return (response as List).map((item) => FoodItem.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching food items: $e');
      return [];
    }
  }

  static Future<List<String>> getCategories() async {
    try {
      final response = await client
          .from('food_items')
          .select('category')
          .order('category');

      final categories = (response as List)
          .map((item) => (item['category'] as String))
          .toSet()
          .toList();

      return ['All', ...categories.map((c) => _capitalize(c))];
    } catch (e) {
      print('Error fetching categories: $e');
      return ['All', 'Noodles', 'Snacks', 'Beverages'];
    }
  }

  static Future<OperationalHours?> getOperationalHours() async {
    try {
      final response = await client.from('operational_hours').select().single();
      return OperationalHours.fromJson(response);
    } catch (e) {
      print('Error fetching operational hours: $e');
      return null;
    }
  }

  static String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
