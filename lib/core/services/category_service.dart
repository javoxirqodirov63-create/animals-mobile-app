import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category_model.dart';

class CategoryService {
  static List<Category> _categories = [];

  static Future<List<Category>> loadCategories() async {
    if (_categories.isNotEmpty) return _categories;
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/categories.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _categories = jsonList.map((e) => Category.fromJson(e)).toList();
      return _categories;
    } catch (e) {
      return [];
    }
  }

  static List<Category> get categories => _categories;
}
