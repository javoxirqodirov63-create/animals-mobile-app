import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favCount = context.watch<ListingProvider>().favoriteListings.length;

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
        title: const Text(
          'Profil',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. Foydalanuvchi ma'lumotlari kartasi (Och Bardo Neon Profil)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFFECDD3),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0CBE123C),
                    blurRadius: 16,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFBE123C), Color(0xFFFB7185)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40BE123C),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 34,
                              color: Colors.white,
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: Icon(
                              Icons.verified_rounded,
                              size: 18,
                              color: Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mehmon foydalanuvchi',
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFF86EFAC),
                                ),
                              ),
                              child: const Text(
                                '✓ Ishonchli profil',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF065F46),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFFFF1F2)),
                  const SizedBox(height: 12),

                  // Statistika paneli
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Faol e\'lonlar', '0 ta'),
                      Container(height: 28, width: 1, color: const Color(0xFFFECDD3)),
                      _buildStatItem('Sevimlilar', '$favCount ta'),
                      Container(height: 28, width: 1, color: const Color(0xFFFECDD3)),
                      _buildStatItem('Reyting', '★ 5.0'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // 2. Bo'limlar ro'yxati
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFFECDD3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0ABE123C),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _buildTile(
                      icon: Icons.inventory_2_outlined,
                      iconColor: const Color(0xFFBE123C),
                      title: 'Mening e\'lonlarim',
                      onTap: () {},
                    ),
                    const Divider(
                        height: 1, indent: 56, color: Color(0xFFFFF1F2)),
                    _buildTile(
                      icon: Icons.history_rounded,
                      iconColor: const Color(0xFFD97706),
                      title: 'Ko\'rilgan e\'lonlar',
                      onTap: () {},
                    ),
                    const Divider(
                        height: 1, indent: 56, color: Color(0xFFFFF1F2)),
                    _buildTile(
                      icon: Icons.notifications_outlined,
                      iconColor: const Color(0xFFBE123C),
                      title: 'Xabarlar va bildirishnomalar',
                      onTap: () {},
                    ),
                    const Divider(
                        height: 1, indent: 56, color: Color(0xFFFFF1F2)),
                    _buildTile(
                      icon: Icons.support_agent_rounded,
                      iconColor: const Color(0xFF059669),
                      title: 'Qo\'llab-quvvatlash xizmati',
                      onTap: () {},
                    ),
                    const Divider(
                        height: 1, indent: 56, color: Color(0xFFFFF1F2)),
                    _buildTile(
                      icon: Icons.settings_outlined,
                      iconColor: const Color(0xFF64748B),
                      title: 'Sozlamalar',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Versiya ma'lumoti
            const Text(
              'Animals-uz • Och Bardo Neon v2.5.0',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Color(0xFFBE123C),
            shadows: [
              Shadow(
                color: Color(0xFFFDA4AF),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(7.5),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1F2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFFECDD3),
            width: 0.8,
          ),
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 13, color: Color(0xFF94A3B8)),
      onTap: onTap,
    );
  }
}
