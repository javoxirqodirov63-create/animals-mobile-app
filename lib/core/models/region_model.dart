class Region {
  final int id;
  final String nameUz;
  final String nameRu;
  final List<District> districts;

  Region({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.districts,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'] as int,
      nameUz: json['name_uz'] as String,
      nameRu: json['name_ru'] as String,
      districts: (json['districts'] as List<dynamic>?)
              ?.map((d) => District.fromJson(d as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class District {
  final int id;
  final String nameUz;
  final String nameRu;

  District({
    required this.id,
    required this.nameUz,
    required this.nameRu,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as int,
      nameUz: json['name_uz'] as String,
      nameRu: json['name_ru'] as String,
    );
  }
}
