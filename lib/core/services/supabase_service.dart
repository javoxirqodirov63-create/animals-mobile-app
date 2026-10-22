import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/listing_model.dart';

class SupabaseService {
  // ==============================================================
  // O'z loyihangiz ma'lumotlarini supabase.com dan olib bu yerga qo'yasiz:
  // ==============================================================
  static const String supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  static bool get isConfigured =>
      supabaseUrl != 'https://YOUR_PROJECT_ID.supabase.co' &&
      supabaseAnonKey != 'YOUR_SUPABASE_ANON_KEY';

  static Future<void> initialize() async {
    if (isConfigured) {
      try {
        await Supabase.initialize(
          url: supabaseUrl,
          publishableKey: supabaseAnonKey,
        );
      } catch (e) {
        debugPrint('Supabase initializatsiya xatosi: $e');
      }
    }
  }

  // Barcha e'lonlarni onlayn bazadan olish
  static Future<List<Listing>> fetchListings() async {
    if (!isConfigured) return [];
    try {
      final response = await Supabase.instance.client
          .from('listings')
          .select()
          .order('created_at', ascending: false);

      final List<dynamic> data = response as List<dynamic>;
      return data.map((item) {
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
          imageUrls: (item['image_urls'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
          createdAt: DateTime.tryParse(item['created_at'] ?? '') ??
              DateTime.now(),
          viewsCount: item['views_count'] as int? ?? 0,
        );
      }).toList();
    } catch (e) {
      debugPrint('E\'lonlarni yuklashda xatolik: $e');
      return [];
    }
  }

  // Yangi e'lonni onlayn bazaga yozish
  static Future<bool> createListing(Listing listing) async {
    if (!isConfigured) return false;
    try {
      await Supabase.instance.client.from('listings').insert({
        'id': listing.id,
        'title': listing.title,
        'description': listing.description,
        'price': listing.price,
        'currency': listing.currency,
        'is_negotiable': listing.isNegotiable,
        'category_id': listing.categoryId,
        'category_name': listing.categoryName,
        'region_id': listing.regionId,
        'region_name': listing.regionName,
        'district_id': listing.districtId,
        'district_name': listing.districtName,
        'contact_phone': listing.contactPhone,
        'seller_name': listing.sellerName,
        'image_urls': listing.imageUrls,
        'created_at': listing.createdAt.toIso8601String(),
      });
      return true;
    } catch (e) {
      debugPrint('E\'lonni saqlashda xatolik: $e');
      return false;
    }
  }
}
