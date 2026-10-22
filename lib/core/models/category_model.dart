class Category {
  final int id;
  final String slug;
  final String nameUz;
  final String nameRu;
  final String icon;
  final List<SubCategory> subcategories;

  Category({
    required this.id,
    required this.slug,
    required this.nameUz,
    required this.nameRu,
    required this.icon,
    required this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      slug: json['slug'] as String,
      nameUz: json['name_uz'] as String,
      nameRu: json['name_ru'] as String,
      icon: json['icon'] as String,
      subcategories: (json['subcategories'] as List<dynamic>?)
              ?.map((s) => SubCategory.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class SubCategory {
  final int id;
  final String nameUz;
  final String nameRu;

  SubCategory({
    required this.id,
    required this.nameUz,
    required this.nameRu,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as int,
      nameUz: json['name_uz'] as String,
      nameRu: json['name_ru'] as String,
    );
  }
}
