import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/listing_model.dart';

class ApiService {
  // O'zimizning FastAPI serverimiz manzili
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Serverdagi barcha e'lonlarni yuklab olish
  static Future<List<Listing>> fetchListings() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/listings'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((item) {
          final List<dynamic> rawImages = (item['image_urls'] as List<dynamic>?) ?? [];
          final List<String> images = rawImages.map((e) => e.toString()).toList();
          if (images.isEmpty && item['primary_image_url'] != null) {
            images.add(item['primary_image_url'].toString());
          }

          return Listing(
            id: item['id'].toString(),
            title: item['title'] ?? '',
            description: item['description'] ?? '',
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            currency: item['currency'] ?? 'UZS',
            isNegotiable: item['is_negotiable'] ?? true,
            categoryId: item['category_id'] as int? ?? 1,
            categoryName: item['category_name'] ?? '',
            regionId: item['region_id'] as int? ?? 1,
            regionName: item['region_name'] ?? '',
            districtId: item['district_id'] as int? ?? 1,
            districtName: item['district_name'] ?? '',
            contactPhone: item['contact_phone'] ?? '',
            sellerName: item['seller_name'] ?? 'Foydalanuvchi',
            imageUrls: images,
            createdAt: DateTime.tryParse(item['created_at'] ?? '') ??
                DateTime.now(),
            viewsCount: item['views_count'] as int? ?? 0,
            breed: item['breed'] ?? '',
            age: item['age'] ?? '',
            gender: item['gender'] ?? 'Erkak',
            isVaccinated: item['is_vaccinated'] ?? true,
            hasPassport: item['has_passport'] ?? true,
            isFeatured: item['is_featured'] ?? false,
            isVerifiedSeller: item['is_verified_seller'] ?? true,
            sellerRating: (item['seller_rating'] as num?)?.toDouble() ?? 4.9,
            sellerReviewCount: item['seller_review_count'] as int? ?? 18,
          );
        }).toList();
      }
    } catch (e) {
      debugPrint('Serverdan ma\'lumot olishda xato: $e');
    }
    return [];
  }

  // Yangi e'lonni serverga saqlash
  static Future<bool> createListing(Listing listing) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/listings'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'category_id': listing.categoryId,
              'district_id': listing.districtId,
              'title': listing.title,
              'description': listing.description,
              'price': listing.price,
              'currency': listing.currency,
              'price_type': listing.isNegotiable ? 'negotiable' : 'fixed',
              'breed': listing.breed,
              'gender': listing.gender == 'Urg\'ochi' ? 'female' : 'male',
              'contact_phone': listing.contactPhone.isNotEmpty ? listing.contactPhone : '+998901234567',
              'image_urls': listing.imageUrls,
            }),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      debugPrint('Serverga saqlashda xato: $e');
      return false;
    }
  }
}
