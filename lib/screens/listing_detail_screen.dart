import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_colors.dart';
import '../core/models/listing_model.dart';
import '../providers/listing_provider.dart';

class ListingDetailScreen extends StatefulWidget {
  final Listing listing;

  const ListingDetailScreen({super.key, required this.listing});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  int _selectedImageIndex = 0;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: cleanPhone,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _sendSms(String phoneNumber) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: cleanPhone,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listing = widget.listing;
    final images = listing.imageUrls.isNotEmpty
        ? listing.imageUrls
        : ['https://via.placeholder.com/600'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFFECDD3),
            height: 1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 19, color: Color(0xFFBE123C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          listing.categoryName,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.5,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          Consumer<ListingProvider>(
            builder: (context, provider, child) {
              final isFav = listing.isFavorite;
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? const Color(0xFFBE123C) : const Color(0xFF94A3B8),
                  size: 22,
                ),
                onPressed: () => provider.toggleFavorite(listing.id),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined,
                size: 21, color: Color(0xFF64748B)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('E\'lon havolasi nusxalandi'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Fotogalereya (Yevropa andozasidagi interaktiv karusel)
            Stack(
              children: [
                SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (idx) =>
                        setState(() => _selectedImageIndex = idx),
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, st) => Container(
                          color: AppColors.borderLight,
                          child: const Icon(Icons.pets,
                              size: 64, color: AppColors.textLight),
                        ),
                      );
                    },
                  ),
                ),

                // Rasm hisoblagichi (1/2 badge)
                Positioned(
                  bottom: 12,
                  right: 14,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_selectedImageIndex + 1} / ${images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                // Agar sara bo'lsa nishon
                if (listing.isFeatured)
                  Positioned(
                    top: 12,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded,
                              size: 14, color: Color(0xFFB45309)),
                          SizedBox(width: 4),
                          Text(
                            'Hafta tanlovi',
                            style: TextStyle(
                              color: Color(0xFF92400E),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // 2. Kontent va Yevropa andozasidagi ma'lumotlar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Narx va Kelishuv
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        listing.formattedPrice,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFBE123C),
                          letterSpacing: -0.3,
                          shadows: [
                            Shadow(
                              color: Color(0xFFFDA4AF),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      if (listing.isNegotiable)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4.5),
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryLight.withValues(alpha: 0.4),
                            ),
                          ),
                          child: const Text(
                            'Kelishiladi',
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Sarlavha
                  Text(
                    listing.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Vaqt va ko'rishlar
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          size: 13, color: AppColors.textLight),
                      const SizedBox(width: 4),
                      Text(
                        'Joylashtirildi: ${listing.timeAgo}',
                        style: const TextStyle(
                            fontSize: 11.5, color: AppColors.textSecondary),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.remove_red_eye_outlined,
                          size: 13, color: AppColors.textLight),
                      const SizedBox(width: 4),
                      Text(
                        'Ko\'rishlar: ${listing.viewsCount}',
                        style: const TextStyle(
                            fontSize: 11.5, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3. Yevropa andozasidagi parametrlar matritsasi (Specification Grid)
                  const Text(
                    'Xususiyatlar va ko\'rsatkichlar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                      boxShadow: AppColors.softCardShadow,
                    ),
                    child: Column(
                      children: [
                        _buildSpecRow(
                          icon1: Icons.pets_rounded,
                          label1: 'Zoti',
                          val1: listing.breed.isNotEmpty
                              ? listing.breed
                              : listing.categoryName,
                          icon2: Icons.cake_outlined,
                          label2: 'Yoshi',
                          val2: listing.age.isNotEmpty
                              ? listing.age
                              : 'Ko\'rsatilmagan',
                        ),
                        const Divider(height: 18, color: AppColors.borderLight),
                        _buildSpecRow(
                          icon1: Icons.male_rounded,
                          label1: 'Jinsi',
                          val1: listing.gender,
                          icon2: Icons.medical_services_outlined,
                          label2: 'Emlash holati',
                          val2: listing.isVaccinated
                              ? '✓ Emlangan'
                              : 'Emlanmagan',
                        ),
                        const Divider(height: 18, color: AppColors.borderLight),
                        _buildSpecRow(
                          icon1: Icons.verified_user_outlined,
                          label1: 'Vet pasport',
                          val1: listing.hasPassport ? '✓ Mavjud' : 'Yo\'q',
                          icon2: Icons.location_on_outlined,
                          label2: 'Hudud',
                          val2: listing.regionName
                              .replaceAll(" viloyati", "")
                              .replaceAll(" shahri", ""),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Salomatlik va Veterinar kafolati (Health Guarantee)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primaryLight.withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.health_and_safety_rounded,
                            color: AppColors.primary, size: 26),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Veterinar nazorati va kafolat',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Hayvon sog\'lom, parazitlarga qarshi dori berilgan va parvarish qilingan.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 5. Tavsif va to'liq ma'lumot
                  const Text(
                    'E\'lon tavsifi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      listing.description,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: AppColors.textPrimary,
                        height: 1.55,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 6. Sotuvchi profili (European Verified Seller Card)
                  const Text(
                    'Sotuvchi haqida',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                      boxShadow: AppColors.softCardShadow,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.primarySoft,
                                  child: const Icon(Icons.person,
                                      color: AppColors.primary, size: 28),
                                ),
                                if (listing.isVerifiedSeller)
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(Icons.verified_rounded,
                                        size: 16,
                                        color: AppColors.verifiedBlue),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        listing.sellerName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded,
                                          size: 15, color: Color(0xFFF59E0B)),
                                      const SizedBox(width: 3),
                                      Text(
                                        '${listing.sellerRating}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.5,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        ' (${listing.sellerReviewCount} ta baho)',
                                        style: const TextStyle(
                                          fontSize: 11.5,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 18, color: AppColors.borderLight),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.bolt_rounded,
                                    size: 14, color: AppColors.primary),
                                SizedBox(width: 4),
                                Text(
                                  'Javob vaqti: 15 daqiqa',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '2023 yildan beri',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 7. Yevropa andozasidagi xavfsizlik maslahati (Pets4Homes standard)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7).withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFDE68A),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_outlined,
                            size: 20, color: Color(0xFFB45309)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Xavfsiz xarid qilish qoidasi: Hayvonni o\'z ko\'zingiz bilan ko\'rmasdan yoki veterinarga ko\'rsatmasdan turib hech qachon karta orqali oldindan to\'lov qilmang.',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF92400E),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _makePhoneCall(listing.contactPhone),
                icon: const Icon(Icons.phone_rounded,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Qo\'ng\'iroq qilish',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () => _sendSms(listing.contactPhone),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Icon(Icons.sms_rounded, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow({
    required IconData icon1,
    required String label1,
    required String val1,
    required IconData icon2,
    required String label2,
    required String val2,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(icon1, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label1,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      val1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              Icon(icon2, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label2,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: AppColors.textLight,
                      ),
                    ),
                    Text(
                      val2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
