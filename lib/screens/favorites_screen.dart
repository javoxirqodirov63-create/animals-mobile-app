import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../widgets/listing_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    final favorites = provider.favoriteListings;

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
          'Sevimlilar',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 19,
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
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFF1F2),
                      border: Border.all(
                        color: const Color(0xFFFECDD3),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1ABE123C),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      size: 48,
                      color: Color(0xFFBE123C),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Sevimli e\'lonlar yo\'q',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'O\'zingizga yoqqan hayvonlarni yurakchani\nbosib bu yerga saqlashingiz mumkin',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListingCard(listing: favorites[index]);
              },
            ),
    );
  }
}
