import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/models/listing_model.dart';
import '../providers/listing_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/listing_detail_screen.dart';

class ListingCard extends StatefulWidget {
  final Listing listing;

  const ListingCard({super.key, required this.listing});

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final listing = widget.listing;
    final config = context.watch<ThemeProvider>().config;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -3.5 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white, // TALAB BO'YICHA: TOZA OQ FON
          borderRadius: BorderRadius.circular(config.cardRadius),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFFFB7185)
                : const Color(0xFFFECDD3),
            width: _isHovered ? 1.4 : 1.0,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFFB7185).withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: const Color(0xFFBE123C).withValues(alpha: 0.15),
                    blurRadius: 12,
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFFBE123C).withValues(alpha: 0.07),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(config.cardRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(config.cardRadius),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListingDetailScreen(listing: listing),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Rasm qismi va Och Bardo Mikronishonlar
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(config.cardRadius - 1),
                      ),
                      child: SizedBox(
                        height: 132,
                        width: double.infinity,
                        child: Image.network(
                          listing.imageUrls.isNotEmpty
                              ? listing.imageUrls.first
                              : 'https://via.placeholder.com/300',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: const Color(0xFFFFF1F2),
                            child: const Icon(
                              Icons.pets_rounded,
                              size: 36,
                              color: Color(0xFFFDA4AF),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Yuqori chap: Mikronishonlar
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Row(
                        children: [
                          if (listing.isFeatured)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFFDE68A),
                                  width: 0.9,
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('⭐', style: TextStyle(fontSize: 9)),
                                  SizedBox(width: 3),
                                  Text(
                                    'Sara',
                                    style: TextStyle(
                                      color: Color(0xFF92400E),
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (listing.hasPassport)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF86EFAC),
                                  width: 0.9,
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('🩺', style: TextStyle(fontSize: 9)),
                                  SizedBox(width: 3),
                                  Text(
                                    'Pasport',
                                    style: TextStyle(
                                      color: Color(0xFF065F46),
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Yuqori o'ng: Sevimlilar yurakchasi
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer<ListingProvider>(
                        builder: (context, provider, child) {
                          final isFav = listing.isFavorite;
                          return GestureDetector(
                            onTap: () => provider.toggleFavorite(listing.id),
                            child: Container(
                              padding: const EdgeInsets.all(5.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.92),
                                border: Border.all(
                                  color: isFav
                                      ? const Color(0xFFFB7185)
                                      : const Color(0xFFE2E8F0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav
                                    ? const Color(0xFFBE123C)
                                    : const Color(0xFF94A3B8),
                                size: 15,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Pastki chap: Zoti nishoni (Och Bardo)
                    if (listing.breed.isNotEmpty)
                      Positioned(
                        bottom: 6,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2.5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFBE123C),
                                Color(0xFFFB7185),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFBE123C)
                                    .withValues(alpha: 0.35),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Text(
                            listing.breed,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // 2. Kontent va Ma'lumotlar
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Narx va Kelishiladi nishoni (Och Bardo Neon Yozuv)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              listing.formattedPrice,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFBE123C),
                                letterSpacing: -0.2,
                                shadows: [
                                  Shadow(
                                    color: Color(0xFFFDA4AF),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (listing.isNegotiable)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1F2),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xFFFECDD3),
                                  width: 0.6,
                                ),
                              ),
                              child: const Text(
                                'Kelishiladi',
                                style: TextStyle(
                                  color: Color(0xFFBE123C),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Sarlavha
                      Text(
                        listing.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Parametr nishonlari (Yoshi va Emlash holati)
                      Row(
                        children: [
                          if (listing.age.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.5, vertical: 2),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF5F6),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xFFFECDD3),
                                  width: 0.6,
                                ),
                              ),
                              child: Text(
                                listing.age,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xFFBE123C),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          if (listing.isVaccinated)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.5, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                '✓ Emlangan',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xFF065F46),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Joylashuv va Vaqt
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: Color(0xFFBE123C),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              '${listing.regionName.replaceAll(" viloyati", "").replaceAll(" shahri", "")} • ${listing.timeAgo}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10.5,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (listing.isVerifiedSeller)
                            const Icon(
                              Icons.verified_rounded,
                              size: 13,
                              color: Color(0xFFBE123C),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
