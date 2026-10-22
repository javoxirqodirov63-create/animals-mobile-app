import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/design_variant.dart';
import '../providers/listing_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/add_listing_screen.dart';
import '../screens/favorites_screen.dart';

class NeonAppBarHeader extends StatefulWidget {
  const NeonAppBarHeader({super.key});

  @override
  State<NeonAppBarHeader> createState() => _NeonAppBarHeaderState();
}

class _NeonAppBarHeaderState extends State<NeonAppBarHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _pulseAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showNotificationSheet(BuildContext context, DesignThemeConfig config) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: Color(0xFFFB7185), width: 1.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x29BE123C),
                blurRadius: 24,
                offset: Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFECDD3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFFECDD3),
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: Color(0xFFBE123C),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Bildirishnomalar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF9F1239),
                          shadows: [
                            Shadow(
                              color: Color(0xFFFB7185),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFECDD3),
                        width: 0.8,
                      ),
                    ),
                    child: const Text(
                      '2 ta yangi',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFBE123C),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                icon: Icons.bolt_rounded,
                iconColor: const Color(0xFFBE123C),
                title: '⚡ Och Bardo Neon Uslubi Faollashdi',
                time: 'Hozirgina',
                body: 'Oq fon va nafis och bardo neon yozuvlar bilan yangilangan dizayn ishga tushirildi.',
              ),
              const SizedBox(height: 10),
              _buildNotificationItem(
                icon: Icons.verified_rounded,
                iconColor: const Color(0xFF059669),
                title: '🩺 Veterinar Xulosasi Integratsiyasi',
                time: '1 soat oldin',
                body: 'Sara zotlar va uy hayvonlari uchun rasmiy veterinar pasporti tekshirildi.',
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE123C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Tushunarli',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFECDD3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: iconColor.withValues(alpha: 0.3),
                width: 0.8,
              ),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final config = themeProvider.config;
    final listingProvider = context.watch<ListingProvider>();
    final favCount = listingProvider.favoriteListings.length;

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final pulse = _pulseAnimation.value;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Yuqori Nafis Och Bardo Tasma (Top Och Bardo Ribbon)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBE123C), // Jonli Och Bardo
                    Color(0xFFFB7185), // Neon Och Bardo Rose
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBE123C)
                        .withValues(alpha: 0.2 + 0.15 * pulse),
                    blurRadius: 8 + 4 * pulse,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5.5),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 920;
                  final isMedium = constraints.maxWidth >= 600;

                  return Row(
                    children: [
                      // Chap tomonda: Rasmiy Bozor Nishoni
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white
                                        .withValues(alpha: 0.4 + 0.3 * pulse),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified_rounded,
                                      size: 11, color: Color(0xFFBE123C)),
                                  SizedBox(width: 3),
                                  Text(
                                    'RASMIY BOZOR',
                                    style: TextStyle(
                                      color: Color(0xFFBE123C),
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                isMedium
                                    ? 'O\'zbekiston bo\'ylab hayvonlar va sara chorva savdosi'
                                    : 'O\'zbekiston #1 Hayvonlar Bozori',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black
                                          .withValues(alpha: 0.25),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // O'rta tomonda: Keng ekranlarda afzalliklar
                      if (isWide)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🩺', style: TextStyle(fontSize: 10.5)),
                              SizedBox(width: 4),
                              Text(
                                'Veterinar Nazorati',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 14),
                              Text('🛡️', style: TextStyle(fontSize: 10.5)),
                              SizedBox(width: 4),
                              Text(
                                'Kafolatlangan Savdo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // O'ng tomonda: Xavfsiz savdo kapsulasi
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 0.8,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt_rounded,
                                size: 11, color: Colors.white),
                            SizedBox(width: 2.5),
                            Text(
                              '100% Xavfsiz Savdo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 2. Asosiy Header (Oq Fon & Och Bardo Neon Yozuvlar)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white, // TALAB BO'YICHA: TOZA OQ FON
                border: const Border(
                  bottom: BorderSide(
                    color: Color(0xFFFECDD3), // Och Bardo chegara
                    width: 1.1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBE123C)
                        .withValues(alpha: 0.06 + 0.04 * pulse),
                    blurRadius: 16 + 6 * pulse,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 1020;
                  final isTablet = constraints.maxWidth >= 640;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Chap tomonda: Brend Logo va Och Bardo Neon Yozuvlar
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Och Bardo Squircle Logo
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFBE123C),
                                    Color(0xFFFB7185),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFBE123C)
                                        .withValues(alpha: 0.35 + 0.25 * pulse),
                                    blurRadius: 12 + 6 * pulse,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.pets_rounded,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // DIQQAT: Unit test talabi bo'yicha 'Animals-uz' matni aniq 1 ta widgetda turadi
                                      Text(
                                        'Animals-uz',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: const Color(0xFF9F1239),
                                          letterSpacing: -0.5,
                                          height: 1.1,
                                          shadows: [
                                            Shadow(
                                              color: const Color(0xFFFB7185)
                                                  .withValues(
                                                      alpha: 0.65 + 0.3 * pulse),
                                              blurRadius: 10 + 6 * pulse,
                                            ),
                                            Shadow(
                                              color: const Color(0xFFBE123C)
                                                  .withValues(alpha: 0.25),
                                              blurRadius: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1.5),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFBE123C),
                                              Color(0xFFFB7185),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFBE123C)
                                                  .withValues(
                                                      alpha: 0.3 + 0.2 * pulse),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          'UZ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFBE123C),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFFB7185)
                                                  .withValues(
                                                      alpha: 0.6 + 0.4 * pulse),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Flexible(
                                        child: Text(
                                          'Hayvonlar & Chorva Savdosi Platformasi',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF64748B),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // O'rta tomonda: Desktop Tezkor Kategoriya Navigatsiyasi (Och Bardo Pills)
                      if (isDesktop)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildNavPill(
                                label: 'Barchasi',
                                emoji: '🐾',
                                isSelected:
                                    listingProvider.selectedCategoryId == null,
                                activeColor: const Color(0xFFBE123C),
                                onTap: () =>
                                    listingProvider.selectCategory(null),
                              ),
                              const SizedBox(width: 6),
                              _buildNavPill(
                                label: 'Uy hayvonlari',
                                emoji: '🐕',
                                isSelected:
                                    listingProvider.selectedCategoryId == 1,
                                activeColor: const Color(0xFFBE123C),
                                onTap: () =>
                                    listingProvider.selectCategory(1),
                              ),
                              const SizedBox(width: 6),
                              _buildNavPill(
                                label: 'Parrandalar',
                                emoji: '🐓',
                                isSelected:
                                    listingProvider.selectedCategoryId == 2,
                                activeColor: const Color(0xFFBE123C),
                                onTap: () =>
                                    listingProvider.selectCategory(2),
                              ),
                              const SizedBox(width: 6),
                              _buildNavPill(
                                label: 'Chorva mollari',
                                emoji: '🐑',
                                isSelected:
                                    listingProvider.selectedCategoryId == 3,
                                activeColor: const Color(0xFFBE123C),
                                onTap: () =>
                                    listingProvider.selectCategory(3),
                              ),
                            ],
                          ),
                        ),

                      // O'ng tomonda: Holat, Sevimlilar, Bildirishnoma va + E'lon berish CTA
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Onlayn holati indikatori (Och Bardo / Yashil pill)
                          if (isTablet) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.5, vertical: 4.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF86EFAC),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6.5,
                                    height: 6.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF10B981)
                                              .withValues(
                                                  alpha: 0.6 + 0.4 * pulse),
                                          blurRadius: 6 + 3 * pulse,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'ONLAYN',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF065F46),
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],

                          // Sevimlilar (Favorites) tugmasi
                          if (isDesktop) ...[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoritesScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF1F2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color(0xFFFECDD3),
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                        favCount > 0
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        size: 18,
                                        color: const Color(0xFFBE123C),
                                      ),
                                      if (favCount > 0)
                                        Positioned(
                                          top: 3,
                                          right: 3,
                                          child: Container(
                                            padding: const EdgeInsets.all(2.5),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFBE123C),
                                              shape: BoxShape.circle,
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                            child: Text(
                                              '$favCount',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 7.5,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],

                          // Bildirishnomalar tugmasi
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () =>
                                  _showNotificationSheet(context, config),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F2),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFFFECDD3),
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(
                                      Icons.notifications_none_rounded,
                                      color: Color(0xFFBE123C),
                                      size: 19,
                                    ),
                                    Positioned(
                                      top: 7,
                                      right: 7,
                                      child: Container(
                                        width: 6.5,
                                        height: 6.5,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE11D48),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFFB7185)
                                                  .withValues(
                                                      alpha: 0.7 + 0.3 * pulse),
                                              blurRadius: 5,
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // "+ E'lon berish" Och Bardo Neon CTA Tugmasi
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(11),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddListingScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11,
                                  vertical: 7.5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFBE123C),
                                      Color(0xFFFB7185),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(11),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFBE123C)
                                          .withValues(alpha: 0.3 + 0.2 * pulse),
                                      blurRadius: 8 + 4 * pulse,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'E\'lon berish',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.1,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFF881337),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildNavPill({
    required String label,
    required String emoji,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFF1F2)
                : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? activeColor
                  : const Color(0xFFFECDD3),
              width: isSelected ? 1.4 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.25),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 11)),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  color: isSelected ? activeColor : const Color(0xFF64748B),
                  shadows: isSelected
                      ? [
                          Shadow(
                            color: const Color(0xFFFB7185).withValues(alpha: 0.7),
                            blurRadius: 6,
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
  }
}
