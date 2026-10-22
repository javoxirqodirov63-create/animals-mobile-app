import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/models/category_model.dart';
import '../core/models/region_model.dart';
import '../core/services/category_service.dart';
import '../core/services/location_service.dart';
import '../providers/listing_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/listing_card.dart';
import '../widgets/neon_app_bar_header.dart';
import '../widgets/trust_banner.dart';
import '../widgets/voldog_hero_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  List<Category> _categories = [];
  List<Region> _regions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
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
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToFeed() {
    _scrollController.animateTo(
      380,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  void _showLocationFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F172A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: Color(0xFF00F0FF), width: 1.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3300F0FF),
                blurRadius: 20,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.92,
            expand: false,
            builder: (context, scrollController) {
              final provider = context.watch<ListingProvider>();
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 8),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on_rounded,
                                color: Color(0xFF00F0FF), size: 22),
                            SizedBox(width: 8),
                            Text(
                              'Hududni tanlang',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        if (provider.selectedRegionId != null)
                          TextButton(
                            onPressed: () {
                              provider.selectLocation(
                                  regionId: null, districtId: null);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Tozalash',
                              style: TextStyle(
                                color: Color(0xFF00F0FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFF1E293B), height: 1),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: _regions.length,
                      itemBuilder: (context, index) {
                        final region = _regions[index];
                        final isSelected =
                            provider.selectedRegionId == region.id;
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF082F49)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: isSelected
                                ? Border.all(
                                    color: const Color(0xFF00F0FF)
                                        .withValues(alpha: 0.5),
                                  )
                                : null,
                          ),
                          child: ListTile(
                            title: Text(
                              region.nameUz,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.normal,
                                color: isSelected
                                    ? const Color(0xFF00F0FF)
                                    : Colors.white,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle_rounded,
                                    color: Color(0xFF00F0FF))
                                : null,
                            onTap: () {
                              provider.selectLocation(regionId: region.id);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String _getCategoryEmoji(int? id) {
    switch (id) {
      case 1:
        return '🐾';
      case 2:
        return '🐓';
      case 3:
        return '🐑';
      default:
        return '🌟';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final config = themeProvider.config;
    final listings = provider.filteredListings;
    final featured = provider.featuredListings;

    String locationLabel = 'Barcha hududlar';
    if (provider.selectedRegionId != null) {
      final found = _regions
          .where((r) => r.id == provider.selectedRegionId)
          .firstOrNull;
      if (found != null) {
        locationLabel = found.nameUz;
      }
    }

    final quickFilters = [
      {'id': 'all', 'label': 'Barchasi', 'emoji': '🌟'},
      {'id': 'featured', 'label': 'Hafta tanlovi', 'emoji': '🔥'},
      {'id': 'newest', 'label': 'Yangi e\'lonlar', 'emoji': '⚡'},
      {'id': 'passport', 'label': 'Pasportli', 'emoji': '🩺'},
      {'id': 'vaccinated', 'label': 'Emlangan', 'emoji': '💉'},
      {'id': 'affordable', 'label': 'Arzonroq', 'emoji': '💰'},
    ];

    return Scaffold(
      backgroundColor: config.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Yuqori qavatdagi Animatsion Neon Animals-uz Header
            const NeonAppBarHeader(),

            // 2. Qidiruv va Hudud tanlash kapsulasi (Och Bardo & Oq Fon)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 6, 14, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFECDD3),
                          width: 1.1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0CBE123C),
                            blurRadius: 12,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (val) => provider.setSearchQuery(val),
                        decoration: InputDecoration(
                          hintText: 'Qidirish (mushuk, ovcharka, tovuq, zot)...',
                          hintStyle: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF94A3B8),
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFFBE123C),
                            size: 21,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    size: 17,
                                    color: Color(0xFF94A3B8),
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    provider.setSearchQuery('');
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Hududni tanlash kapsulasi
                  GestureDetector(
                    onTap: () => _showLocationFilterModal(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF1F2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFECDD3),
                          width: 1.1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0ABE123C),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: Color(0xFFBE123C),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            locationLabel.length > 10
                                ? '${locationLabel.substring(0, 9)}...'
                                : locationLabel,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFBE123C),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 14,
                            color: Color(0xFFBE123C),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Och Bardo Toifalar (Barchasi, Uy hayvonlari, Parrandalar...)
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: _categories.length + 1,
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final isSelected = isAll
                      ? provider.selectedCategoryId == null
                      : provider.selectedCategoryId ==
                          _categories[index - 1].id;
                  final label =
                      isAll ? 'Barchasi' : _categories[index - 1].nameUz;
                  final catId = isAll ? null : _categories[index - 1].id;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => provider.selectCategory(catId),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFBE123C),
                                    Color(0xFFFB7185),
                                  ],
                                )
                              : null,
                          color: isSelected ? null : const Color(0xFFFFF1F2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : const Color(0xFFFECDD3),
                          ),
                          boxShadow: isSelected
                              ? const [
                                  BoxShadow(
                                    color: Color(0x33BE123C),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getCategoryEmoji(catId),
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              label,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFFBE123C),
                                fontWeight: isSelected
                                    ? FontWeight.w900
                                    : FontWeight.w700,
                                fontSize: 12.5,
                                shadows: isSelected
                                    ? const [
                                        Shadow(
                                          color: Color(0xFF881337),
                                          blurRadius: 4,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),

            // 4. Tezkor Filtrlar lentasi
            SizedBox(
              height: 32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: quickFilters.length,
                itemBuilder: (context, index) {
                  final qf = quickFilters[index];
                  final isSelected = provider.quickFilter == qf['id'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => provider.setQuickFilter(qf['id'] as String),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFBE123C)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFBE123C)
                                : const Color(0xFFFECDD3),
                            width: 0.9,
                          ),
                          boxShadow: isSelected
                              ? const [
                                  BoxShadow(
                                    color: Color(0x29BE123C),
                                    blurRadius: 6,
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(qf['emoji'] as String,
                                style: const TextStyle(fontSize: 11)),
                            const SizedBox(width: 4),
                            Text(
                              qf['label'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w900
                                    : FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 5. Asosiy Mazmun va Moslashuvchan Gridi
            Expanded(
              child: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        // Voldog Hero Banner (agar qidiruv yoki toifa tanlanmagan bo'lsa)
                        if (provider.selectedCategoryId == null &&
                            provider.searchQuery.isEmpty)
                          SliverToBoxAdapter(
                            child: VoldogHeroBanner(
                              onExploreTap: _scrollToFeed,
                            ),
                          ),

                        // Sara Zotlar Karuseli (Hafta tanlovi)
                        if (provider.selectedCategoryId == null &&
                            provider.searchQuery.isEmpty &&
                            featured.isNotEmpty)
                          SliverToBoxAdapter(
                            child: FeaturedCarousel(listings: featured),
                          ),

                        // Voldog Xavfsizlik va Kafolat Paneli
                        if (provider.selectedCategoryId == null &&
                            provider.searchQuery.isEmpty)
                          const SliverToBoxAdapter(
                            child: TrustBanner(),
                          ),

                        // E'lonlar Sarlovhasi va Sanog'i
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Barcha e\'lonlar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF9F1239),
                                        letterSpacing: -0.2,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFFFDA4AF),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF1F2),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color(0xFFFECDD3),
                                          width: 0.9,
                                        ),
                                      ),
                                      child: Text(
                                        '${listings.length}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFBE123C),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (provider.selectedCategoryId != null ||
                                    provider.selectedRegionId != null ||
                                    provider.quickFilter != 'all')
                                  GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      provider.clearFilters();
                                      provider.setQuickFilter('all');
                                    },
                                    child: const Text(
                                      'Filtrni tozalash',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFBE123C),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // Bo'sh holat
                        if (listings.isEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off_rounded,
                                      size: 52, color: Colors.grey[400]),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Hech qanday e\'lon topilmadi',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      provider.clearFilters();
                                      provider.setQuickFilter('all');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Barcha e\'lonlarni ko\'rish'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          // Moslashuvchan Voldog Gridi
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(14, 4, 14, 20),
                            sliver: SliverLayoutBuilder(
                              builder: (context, constraints) {
                                int columns = 2;
                                if (constraints.crossAxisExtent > 900) {
                                  columns = 5;
                                } else if (constraints.crossAxisExtent > 650) {
                                  columns = 4;
                                } else if (constraints.crossAxisExtent > 480) {
                                  columns = 3;
                                }

                                return SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: columns,
                                    childAspectRatio: 0.69,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return ListingCard(
                                          listing: listings[index]);
                                    },
                                    childCount: listings.length,
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
