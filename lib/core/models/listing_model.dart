class Listing {
  final String id;
  final String title;
  final String description;
  final double price;
  final String currency;
  final bool isNegotiable;
  final int categoryId;
  final String categoryName;
  final int regionId;
  final String regionName;
  final int districtId;
  final String districtName;
  final String contactPhone;
  final String sellerName;
  final List<String> imageUrls;
  final DateTime createdAt;
  final int viewsCount;
  bool isFavorite;

  // Yevropa andozasidagi qo'shimcha boy parametrlar (European Marketplace attributes)
  final String breed;
  final String age;
  final String gender;
  final bool isVaccinated;
  final bool hasPassport;
  final bool isFeatured;
  final bool isVerifiedSeller;
  final double sellerRating;
  final int sellerReviewCount;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.currency = 'UZS',
    this.isNegotiable = true,
    required this.categoryId,
    required this.categoryName,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.contactPhone,
    required this.sellerName,
    required this.imageUrls,
    required this.createdAt,
    this.viewsCount = 0,
    this.isFavorite = false,
    this.breed = '',
    this.age = '',
    this.gender = 'Erkak',
    this.isVaccinated = true,
    this.hasPassport = true,
    this.isFeatured = false,
    this.isVerifiedSeller = true,
    this.sellerRating = 4.9,
    this.sellerReviewCount = 18,
  });

  String get formattedPrice {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
        );
    return '$formatted $currency';
  }

  String get locationString => '$regionName, $districtName';

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes <= 0 ? 1 : diff.inMinutes} daq oldin';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} soat oldin';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} kun oldin';
    } else {
      return '${(diff.inDays / 7).floor()} hafta oldin';
    }
  }

  Listing copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? currency,
    bool? isNegotiable,
    int? categoryId,
    String? categoryName,
    int? regionId,
    String? regionName,
    int? districtId,
    String? districtName,
    String? contactPhone,
    String? sellerName,
    List<String>? imageUrls,
    DateTime? createdAt,
    int? viewsCount,
    bool? isFavorite,
    String? breed,
    String? age,
    String? gender,
    bool? isVaccinated,
    bool? hasPassport,
    bool? isFeatured,
    bool? isVerifiedSeller,
    double? sellerRating,
    int? sellerReviewCount,
  }) {
    return Listing(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      regionId: regionId ?? this.regionId,
      regionName: regionName ?? this.regionName,
      districtId: districtId ?? this.districtId,
      districtName: districtName ?? this.districtName,
      contactPhone: contactPhone ?? this.contactPhone,
      sellerName: sellerName ?? this.sellerName,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
      viewsCount: viewsCount ?? this.viewsCount,
      isFavorite: isFavorite ?? this.isFavorite,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      isVaccinated: isVaccinated ?? this.isVaccinated,
      hasPassport: hasPassport ?? this.hasPassport,
      isFeatured: isFeatured ?? this.isFeatured,
      isVerifiedSeller: isVerifiedSeller ?? this.isVerifiedSeller,
      sellerRating: sellerRating ?? this.sellerRating,
      sellerReviewCount: sellerReviewCount ?? this.sellerReviewCount,
    );
  }
}
