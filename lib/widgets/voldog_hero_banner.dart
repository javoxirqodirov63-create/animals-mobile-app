import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../screens/add_listing_screen.dart';

class VoldogHeroBanner extends StatefulWidget {
  final VoidCallback onExploreTap;

  const VoldogHeroBanner({super.key, required this.onExploreTap});

  @override
  State<VoldogHeroBanner> createState() => _VoldogHeroBannerState();
}

class _VoldogHeroBannerState extends State<VoldogHeroBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFECDD3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFBE123C).withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.35),
                  width: 0.8,
                ),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                height: 1.15,
                shadows: [
                  Shadow(
                    color: iconColor.withValues(alpha: 0.25),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ThemeProvider>().config;

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glow = _glowAnimation.value;

        return Container(
          margin: const EdgeInsets.fromLTRB(14, 8, 14, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Och Bardo Asosiy Hero Banner (Oq Fon + O'ng tomonda Animatsion Rasmlar Karuseli)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white, // TOZA OQ FON
                  borderRadius: BorderRadius.circular(config.cardRadius + 2),
                  border: Border.all(
                    color: const Color(0xFFFECDD3)
                        .withValues(alpha: 0.8 + 0.2 * glow),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFBE123C)
                          .withValues(alpha: 0.08 + 0.06 * glow),
                      blurRadius: 20 + 8 * glow,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Orqa fondagi ambient och bardo nur doiralari
                    Positioned(
                      top: -25,
                      right: -25,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFFFF1F2)
                                  .withValues(alpha: 0.7 + 0.3 * glow),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -25,
                      left: -25,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFFECDD3)
                                  .withValues(alpha: 0.35 + 0.2 * glow),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Moslashuvchan 2-ustunli Tartib (Chapda Matn, O'ngda Animatsion Uy Hayvonlari Karuseli)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 680;

                        final heroLeftContent = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Och Bardo Neon Pill Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1F2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFFB7185)
                                      .withValues(alpha: 0.5 + 0.3 * glow),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFB7185)
                                        .withValues(alpha: 0.25 + 0.15 * glow),
                                    blurRadius: 8 + 4 * glow,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('⚡',
                                      style: TextStyle(fontSize: 12)),
                                  const SizedBox(width: 5),
                                  Text(
                                    config.heroBadge,
                                    style: TextStyle(
                                      color: const Color(0xFFBE123C),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.3,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0xFFFB7185)
                                              .withValues(
                                                  alpha: 0.5 + 0.3 * glow),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Katta Sarlavha (Och Bardo Neon Yozuvlar)
                            Text(
                              config.heroTitle,
                              style: TextStyle(
                                fontSize: isWide ? 24 : 20,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF9F1239),
                                height: 1.25,
                                letterSpacing: -0.4,
                                shadows: [
                                  Shadow(
                                    color: const Color(0xFFFB7185)
                                        .withValues(alpha: 0.65 + 0.3 * glow),
                                    blurRadius: 10 + 6 * glow,
                                  ),
                                  Shadow(
                                    color: const Color(0xFFBE123C)
                                        .withValues(alpha: 0.25),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Tavsif
                            Text(
                              config.heroSubtitle,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF64748B),
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 2 ta Harakat Tugmasi
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddListingScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFBE123C),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    shadowColor: const Color(0xFFBE123C)
                                        .withValues(alpha: 0.4),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add_circle_outline_rounded,
                                          size: 16, color: Colors.white),
                                      SizedBox(width: 6),
                                      Text(
                                        'E\'lon berish',
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: widget.onExploreTap,
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFF1F2),
                                    foregroundColor: const Color(0xFFBE123C),
                                    side: BorderSide(
                                      color: const Color(0xFFBE123C)
                                          .withValues(alpha: 0.6 + 0.3 * glow),
                                      width: 1.3,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        config.heroCtaText,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFFBE123C),
                                          shadows: [
                                            Shadow(
                                              color: const Color(0xFFFB7185)
                                                  .withValues(alpha: 0.5),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.arrow_downward_rounded,
                                          size: 15, color: Color(0xFFBE123C)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );

                        if (isWide) {
                          // Desktop / Katta ekran: Chapda matn, o'ngda animatsion karusel
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: heroLeftContent,
                              ),
                              const SizedBox(width: 20),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 240,
                                  maxWidth: 290,
                                  minHeight: 280,
                                  maxHeight: 310,
                                ),
                                child: _HeroPetCarousel(glow: glow),
                              ),
                            ],
                          );
                        } else {
                          // Mobil / Kichik ekran: Yuqorida matn, pastida to'liq kartochka
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              heroLeftContent,
                              const SizedBox(height: 18),
                              Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 360,
                                    minHeight: 250,
                                    maxHeight: 270,
                                  ),
                                  child: _HeroPetCarousel(glow: glow),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 2. 3 ta Och Bardo Ishonch va Afzallik Plitkalari
              Row(
                children: [
                  _buildBenefitCard(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Veterinar',
                    subtitle: 'Ko\'rigi & Pasport',
                    iconColor: const Color(0xFFBE123C),
                    iconBg: const Color(0xFFFFF1F2),
                  ),
                  const SizedBox(width: 8),
                  _buildBenefitCard(
                    icon: Icons.verified_user_outlined,
                    title: '100% Xavfsiz',
                    subtitle: 'Ishonchli savdo',
                    iconColor: const Color(0xFF059669),
                    iconBg: const Color(0xFFDCFCE7),
                  ),
                  const SizedBox(width: 8),
                  _buildBenefitCard(
                    icon: Icons.local_shipping_outlined,
                    title: 'Yetkazish',
                    subtitle: 'O\'zbekiston bo\'ylab',
                    iconColor: const Color(0xFFD97706),
                    iconBg: const Color(0xFFFEF3C7),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// O'ng tarafdagi animatsion almashib turadigan uy hayvonlari rasmlari karuseli
/// Foydalanuvchi yuborgan namunaviy skrinshotga 100% moslashtirilgan:
/// - Dumaloq qirrali vertikal kartochka
/// - Chap (<) va o'ng (>) dumaloq tugmalar
/// - Pastdagi oval kapsula ichidagi nuqtalar (faoli uzun oq pill)
/// - 3.8 soniyada silliq animatsiya bilan o'zi almashadi
class _HeroPetCarousel extends StatefulWidget {
  final double glow;

  const _HeroPetCarousel({required this.glow});

  @override
  State<_HeroPetCarousel> createState() => _HeroPetCarouselState();
}

class _HeroPetItem {
  final String name;
  final String category;
  final String emoji;
  final String imageUrl;
  final String status;
  final String price;

  const _HeroPetItem({
    required this.name,
    required this.category,
    required this.emoji,
    required this.imageUrl,
    required this.status,
    required this.price,
  });
}

class _HeroPetCarouselState extends State<_HeroPetCarousel> {
  late final PageController _pageController;
  Timer? _autoSlideTimer;
  int _currentPage = 0;

  static const List<_HeroPetItem> _pets = [
    // 1. Skrinshotdagi yashil to'tiqushga mos
    _HeroPetItem(
      name: 'To\'lqinsimon Sayroqi To\'tiqush',
      category: 'Parrandalar',
      emoji: '🦜',
      imageUrl:
          'https://images.unsplash.com/photo-1552728089-57bdde30beb3?auto=format&fit=crop&w=800&q=80',
      status: 'Faol & Sayroqi',
      price: '250,000 UZS',
    ),
    // 2. Shotland mushukchasi
    _HeroPetItem(
      name: 'Shotland Buklama (Scottish Fold)',
      category: 'Uy hayvonlari',
      emoji: '🐱',
      imageUrl:
          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=800&q=80',
      status: 'Pasportli & Emlangan',
      price: '1,200,000 UZS',
    ),
    // 3. Nemis Ovcharkasi
    _HeroPetItem(
      name: 'Nemis Ovcharkasi (German Shepherd)',
      category: 'Uy hayvonlari',
      emoji: '🐕',
      imageUrl:
          'https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?auto=format&fit=crop&w=800&q=80',
      status: 'Toza naslli kuchukcha',
      price: '2,500,000 UZS',
    ),
    // 4. Mitti Quyoncha
    _HeroPetItem(
      name: 'Mittivoy Xonaki Quyoncha',
      category: 'Uy hayvonlari',
      emoji: '🐰',
      imageUrl:
          'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?auto=format&fit=crop&w=800&q=80',
      status: 'Yuvosh & Bolajon',
      price: '180,000 UZS',
    ),
    // 5. Qorabayir tulpor
    _HeroPetItem(
      name: 'Naslli Qorabayir Toychoq',
      category: 'Chorva & Otlar',
      emoji: '🐎',
      imageUrl:
          'https://images.unsplash.com/photo-1553284965-83fd3e82fa5f?auto=format&fit=crop&w=800&q=80',
      status: 'Shajarali zot',
      price: '24,000,000 UZS',
    ),
    // 6. Oltinrang Retriever
    _HeroPetItem(
      name: 'Oltinrang Retriever (Golden)',
      category: 'Uy hayvonlari',
      emoji: '🦮',
      imageUrl:
          'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=800&q=80',
      status: 'Mehribon xonadon do\'sti',
      price: '3,200,000 UZS',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer =
        Timer.periodic(const Duration(milliseconds: 3800), (timer) {
      if (!mounted || !_pageController.hasClients) return;
      final next = (_currentPage + 1) % _pets.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _goTo(int index) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
    _startTimer();
  }

  void _prev() {
    final target = (_currentPage - 1 + _pets.length) % _pets.length;
    _goTo(target);
  }

  void _next() {
    final target = (_currentPage + 1) % _pets.length;
    _goTo(target);
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFECDD3)
              .withValues(alpha: 0.85 + 0.15 * widget.glow),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBE123C)
                .withValues(alpha: 0.14 + 0.08 * widget.glow),
            blurRadius: 18 + 6 * widget.glow,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // PageView Rasmlar slayderi
            PageView.builder(
              controller: _pageController,
              onPageChanged: (idx) {
                setState(() => _currentPage = idx);
              },
              itemCount: _pets.length,
              itemBuilder: (context, index) {
                final pet = _pets[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Jonivorning yuqori sifatli rasmi
                    Image.network(
                      pet.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFFFF1F2),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(pet.emoji,
                                    style: const TextStyle(fontSize: 48)),
                                const SizedBox(height: 8),
                                Text(
                                  pet.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFBE123C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // Pastki qorong'ilashuvchi gradient (matnlar o'qilishi uchun)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 100,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.78),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Jonivor haqida ma'lumot (Pastda nuqtalardan sal teparoqda)
                    Positioned(
                      bottom: 34,
                      left: 12,
                      right: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  pet.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${pet.emoji} ${pet.status}',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                pet.price,
                                style: const TextStyle(
                                  color: Color(0xFFFECDD3),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            // Tepada Neon jonivorlar ko'rsatkichi (Pill badge)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFFB7185).withValues(alpha: 0.7),
                    width: 0.9,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🐾', style: TextStyle(fontSize: 10)),
                    const SizedBox(width: 4),
                    Text(
                      '${_currentPage + 1}/${_pets.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Chapga tugmasi (<) - Skrinshotdagi kabi frosted doira
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _prev,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.45),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.45),
                          width: 0.9,
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // O'ngga tugmasi (>) - Skrinshotdagi kabi frosted doira
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _next,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.45),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.45),
                          width: 0.9,
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Pastki Slayder Nuqtalari Kapsulasi (Skrinshotdagi kabi)
            Positioned(
              bottom: 9,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_pets.length, (i) {
                      final isActive = i == _currentPage;
                      return GestureDetector(
                        onTap: () => _goTo(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOutCubic,
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          width: isActive ? 20 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
