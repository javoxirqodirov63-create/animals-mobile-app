import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../core/constants/app_colors.dart';
import '../core/models/category_model.dart';
import '../core/models/listing_model.dart';
import '../core/models/region_model.dart';
import '../core/services/category_service.dart';
import '../core/services/location_service.dart';
import '../providers/listing_provider.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController(text: '+998 ');
  final _sellerController = TextEditingController();
  final _imageUrlController = TextEditingController();

  Category? _selectedCategory;
  Region? _selectedRegion;
  District? _selectedDistrict;
  bool _isNegotiable = true;
  bool _isVaccinated = true;
  bool _hasPassport = true;

  List<Category> _categories = [];
  List<Region> _regions = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final categories = await CategoryService.loadCategories();
    final regions = await LocationService.loadRegions();
    if (mounted) {
      setState(() {
        _categories = categories;
        _regions = regions;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _phoneController.dispose();
    _sellerController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitListing() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, hayvon toifasini tanlang'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    if (_selectedRegion == null || _selectedDistrict == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, viloyat va tumanni tanlang'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final price =
        double.tryParse(_priceController.text.replaceAll(' ', '')) ?? 0;
    final imageUrl = _imageUrlController.text.trim().isNotEmpty
        ? _imageUrlController.text.trim()
        : 'https://images.unsplash.com/photo-1546445317-29f4545e9d53?auto=format&fit=crop&w=600&q=80';

    final newListing = Listing(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      breed: _breedController.text.trim(),
      age: _ageController.text.trim(),
      isVaccinated: _isVaccinated,
      hasPassport: _hasPassport,
      isVerifiedSeller: true,
      sellerRating: 5.0,
      sellerReviewCount: 1,
      description: _descController.text.trim(),
      price: price,
      currency: 'UZS',
      isNegotiable: _isNegotiable,
      categoryId: _selectedCategory!.id,
      categoryName: _selectedCategory!.nameUz,
      regionId: _selectedRegion!.id,
      regionName: _selectedRegion!.nameUz,
      districtId: _selectedDistrict!.id,
      districtName: _selectedDistrict!.nameUz,
      contactPhone: _phoneController.text.trim(),
      sellerName: _sellerController.text.trim().isNotEmpty
          ? _sellerController.text.trim()
          : 'Foydalanuvchi',
      imageUrls: [imageUrl],
      createdAt: DateTime.now(),
    );

    context.read<ListingProvider>().addListing(newListing);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E\'loningiz muvaffaqiyatli joylashtirildi!'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
      filled: true,
      fillColor: const Color(0xFFFFF1F2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFECDD3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFECDD3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFBE123C), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFBE123C)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFFECDD3),
            height: 1,
          ),
        ),
        title: const Text(
          'Yangi e\'lon berish',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
            color: Color(0xFF9F1239),
            shadows: [
              Shadow(
                color: Color(0xFFFDA4AF),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toifa tanlash
              const Text(
                'Hayvon toifasi *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<Category>(
                initialValue: _selectedCategory,
                dropdownColor: Colors.white,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration('Toifani tanlang'),
                items: _categories.map((c) {
                  return DropdownMenuItem(
                    value: c,
                    child: Text(c.nameUz),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => _selectedCategory = val);
                },
              ),
              const SizedBox(height: 14),

              // Sarlavha
              const Text(
                'E\'lon sarlavhasi *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration:
                    _buildInputDecoration('Masalan: Shotland mushukchasi'),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Sarlavhani kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Zoti va Yoshi (Row)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hayvon zoti',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.5),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _breedController,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration:
                              _buildInputDecoration('Masalan: Scottish Fold'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Yoshi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.5),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _ageController,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration:
                              _buildInputDecoration('Masalan: 2 oylik'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Salomatlik va Pasport belgilari
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isVaccinated,
                          activeColor: AppColors.primary,
                          onChanged: (val) =>
                              setState(() => _isVaccinated = val ?? true),
                        ),
                        const Expanded(
                          child: Text(
                            'Hayvon emlangan (vaksina qilingan)',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _hasPassport,
                          activeColor: AppColors.primary,
                          onChanged: (val) =>
                              setState(() => _hasPassport = val ?? true),
                        ),
                        const Expanded(
                          child: Text(
                            'Veterinariya pasporti mavjud',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Narx
              const Text(
                'Narxi (so\'mda) *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration('Masalan: 1 200 000')
                    .copyWith(
                  suffixText: 'UZS',
                  suffixStyle: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Narxni kiriting';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isNegotiable,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() => _isNegotiable = val ?? true);
                    },
                  ),
                  const Text(
                    'Savdolashish mumkin (Kelishiladi)',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Viloyat
              const Text(
                'Viloyat *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<Region>(
                initialValue: _selectedRegion,
                dropdownColor: Colors.white,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration('Viloyatni tanlang'),
                items: _regions.map((r) {
                  return DropdownMenuItem(
                    value: r,
                    child: Text(r.nameUz),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedRegion = val;
                    _selectedDistrict = null;
                  });
                },
              ),
              const SizedBox(height: 14),

              // Tuman
              if (_selectedRegion != null) ...[
                const Text(
                  'Tuman / Shahar *',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<District>(
                  initialValue: _selectedDistrict,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _buildInputDecoration('Tumanni tanlang'),
                  items: _selectedRegion!.districts.map((d) {
                    return DropdownMenuItem(
                      value: d,
                      child: Text(d.nameUz),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _selectedDistrict = val);
                  },
                ),
                const SizedBox(height: 14),
              ],

              // Telefon raqam
              const Text(
                'Telefon raqamingiz *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration('+998 90 123 45 67'),
                validator: (val) {
                  if (val == null || val.trim().length < 9) {
                    return 'Telefon raqamni to\'liq kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Sotuvchi ismi
              const Text(
                'Ismingiz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _sellerController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration('Masalan: Alisher'),
              ),
              const SizedBox(height: 14),

              // Tavsif
              const Text(
                'Tavsif (yoshi, vazni, holati)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration(
                    'Jonivor haqida ma\'lumot yozing...'),
              ),
              const SizedBox(height: 14),

              // Rasm URL
              const Text(
                'Rasm URL manzili (ixtiyoriy)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _imageUrlController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _buildInputDecoration('https://...'),
              ),
              const SizedBox(height: 24),

              // Chiqarish tugmasi
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitListing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 1,
                  ),
                  child: const Text(
                    'E\'lonni joylashtirish',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
