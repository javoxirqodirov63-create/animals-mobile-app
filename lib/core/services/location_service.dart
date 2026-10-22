import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/region_model.dart';

class LocationService {
  static List<Region> _regions = [];

  static Future<List<Region>> loadRegions() async {
    if (_regions.isNotEmpty) return _regions;
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/regions_districts.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _regions = jsonList.map((e) => Region.fromJson(e)).toList();
      return _regions;
    } catch (e) {
      return [];
    }
  }

  static List<Region> get regions => _regions;
}
