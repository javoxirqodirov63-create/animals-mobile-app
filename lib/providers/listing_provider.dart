import 'package:flutter/material.dart';
import '../core/models/listing_model.dart';
import '../core/services/api_service.dart';
import '../core/services/mock_data_service.dart';
import '../core/services/supabase_service.dart';

class ListingProvider with ChangeNotifier {
  List<Listing> _listings = [];
  bool _isLoading = false;
  String _searchQuery = '';
  int? _selectedCategoryId;
  int? _selectedRegionId;
  int? _selectedDistrictId;

  ListingProvider() {
    _initListings();
  }

  bool get isLoading => _isLoading;
  List<Listing> get allListings => _listings;

  Future<void> _initListings() async {
    _listings = MockDataService.getInitialListings();

    // 1. O'zimizning serverimizdan yuklash
    try {
      _isLoading = true;
      notifyListeners();

      final serverListings = await ApiService.fetchListings();
      if (serverListings.isNotEmpty) {
        _listings = serverListings;
      }
    } catch (_) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    // 2. Agar Supabase sozlangan bo'lsa
    if (SupabaseService.isConfigured) {
      final onlineListings = await SupabaseService.fetchListings();
      if (onlineListings.isNotEmpty) {
        _listings = onlineListings;
        notifyListeners();
      }
    }
  }

  String _quickFilter = 'all'; // 'all', 'featured', 'newest', 'vaccinated', 'passport', 'affordable'

  List<Listing> get featuredListings {
    return _listings.where((item) => item.isFeatured).toList();
  }

  List<Listing> get filteredListings {
    var result = _listings.where((listing) {
      // Qidiruv filtri
      final matchesQuery = _searchQuery.isEmpty ||
          listing.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          listing.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          listing.breed.toLowerCase().contains(_searchQuery.toLowerCase());

      // Kategoriya filtri
      final matchesCategory = _selectedCategoryId == null ||
          listing.categoryId == _selectedCategoryId;

      // Hudud filtri
      final matchesRegion = _selectedRegionId == null ||
          listing.regionId == _selectedRegionId;

      final matchesDistrict = _selectedDistrictId == null ||
          listing.districtId == _selectedDistrictId;

      // Tezkor filtr
      bool matchesQuick = true;
      if (_quickFilter == 'featured') {
        matchesQuick = listing.isFeatured;
      } else if (_quickFilter == 'vaccinated') {
        matchesQuick = listing.isVaccinated;
      } else if (_quickFilter == 'passport') {
        matchesQuick = listing.hasPassport;
      }

      return matchesQuery && matchesCategory && matchesRegion && matchesDistrict && matchesQuick;
    }).toList();

    if (_quickFilter == 'newest') {
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_quickFilter == 'affordable') {
      result.sort((a, b) => a.price.compareTo(b.price));
    }

    return result;
  }

  List<Listing> get favoriteListings {
    return _listings.where((item) => item.isFavorite).toList();
  }

  String get searchQuery => _searchQuery;
  String get quickFilter => _quickFilter;
  int? get selectedCategoryId => _selectedCategoryId;
  int? get selectedRegionId => _selectedRegionId;
  int? get selectedDistrictId => _selectedDistrictId;

  void setQuickFilter(String filter) {
    _quickFilter = filter;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectCategory(int? categoryId) {
    if (_selectedCategoryId == categoryId) {
      _selectedCategoryId = null; // Toggle off if clicked again
    } else {
      _selectedCategoryId = categoryId;
    }
    notifyListeners();
  }

  void selectLocation({int? regionId, int? districtId}) {
    _selectedRegionId = regionId;
    _selectedDistrictId = districtId;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategoryId = null;
    _selectedRegionId = null;
    _selectedDistrictId = null;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _listings.indexWhere((item) => item.id == id);
    if (index != -1) {
      _listings[index].isFavorite = !_listings[index].isFavorite;
      notifyListeners();
    }
  }

  Future<void> addListing(Listing listing) async {
    _listings.insert(0, listing);
    notifyListeners();

    // Serverga yuborish
    await ApiService.createListing(listing);

    // Supabase ga yuborish (agar ulangan bo'lsa)
    if (SupabaseService.isConfigured) {
      await SupabaseService.createListing(listing);
    }
  }
}
