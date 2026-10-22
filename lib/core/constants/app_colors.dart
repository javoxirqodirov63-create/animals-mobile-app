import 'package:flutter/material.dart';

/// Animals-uz Oq Fon va Och Bardo Neon Rang Palitrasi
class AppColors {
  // Asosiy Och Bardo Ranglar (Light / Bright Rose-Bordeaux Neon)
  static const Color neonBardo = Color(0xFFBE123C); // Jonli Och Bardo
  static const Color neonBardoDeep = Color(0xFF9F1239); // Nafis Bardo
  static const Color neonRose = Color(0xFFFB7185); // Yorqin Och Bardo Neon
  static const Color neonPink = Color(0xFFFDA4AF); // Nozik Och Bardo
  static const Color neonSoftBg = Color(0xFFFFF1F2); // Rose 50 - juda nozik och bardo yuzasi
  static const Color neonBorder = Color(0xFFFECDD3); // Rose 200 - och bardo chegara

  // Asosiy Brand Ranglar
  static const Color primary = neonBardo;
  static const Color primaryDark = neonBardoDeep;
  static const Color primaryAccent = neonRose;
  static const Color primaryLight = neonPink;
  static const Color primarySoft = neonSoftBg;
  static const Color primarySoftBorder = neonBorder;

  // Oltin va Qo'shimcha Aksentlar
  static const Color amber = Color(0xFFF59E0B);
  static const Color amberDark = Color(0xFFD97706);
  static const Color amberLight = Color(0xFFFDE68A);
  static const Color amberSoft = Color(0xFFFEF3C7);
  static const Color amberDeep = Color(0xFF92400E);

  static const Color honey = amber;
  static const Color honeyDark = amberDark;
  static const Color coral = Color(0xFFFF6B4A);
  static const Color terracotta = Color(0xFFEA580C);

  // Orqa Fonlar (TALAB BO'YICHA: TOZA OQ RANG)
  static const Color background = Colors.white; // Sof OQ orqa fon
  static const Color surface = Colors.white; // Sof oq kartochkalar
  static const Color cardColor = Colors.white;
  static const Color cardWarm = Color(0xFFFFF5F6); // Nozik och bardo ilig'i

  // Chegaralar va Chiziqlar (Och bardo hoshiyalar)
  static const Color border = Color(0xFFFECDD3); // Och bardo hoshiya
  static const Color borderLight = Color(0xFFFFF1F2);
  static const Color divider = Color(0xFFFEE2E2);

  // Matn Ranglari
  static const Color textPrimary = Color(0xFF0F172A); // Midnight Slate
  static const Color textSecondary = Color(0xFF64748B); // Slate kumush
  static const Color textLight = Color(0xFF94A3B8);
  static const Color textBardo = Color(0xFF9F1239); // Och bardo matn

  // Holatlar va Nufuz
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFE11D48);
  static const Color warning = Color(0xFFF59E0B);
  static const Color favoriteRed = Color(0xFFE11D48);
  static const Color verifiedBlue = Color(0xFF2563EB);

  // Mikronishon Ranglari (Och Bardo & Pastel)
  static const Color tagMintBg = Color(0xFFDCFCE7);
  static const Color tagMintText = Color(0xFF065F46);
  static const Color tagEmeraldBg = tagMintBg;
  static const Color tagEmeraldText = tagMintText;

  static const Color tagHoneyBg = Color(0xFFFEF3C7);
  static const Color tagHoneyText = Color(0xFF92400E);

  static const Color tagPeachBg = Color(0xFFFFF1F2);
  static const Color tagPeachText = Color(0xFFBE123C);

  static const Color tagSkyBg = Color(0xFFE0F2FE);
  static const Color tagSkyText = Color(0xFF0284C7);

  static const Color tagLavenderBg = Color(0xFFF3E8FF);
  static const Color tagLavenderText = Color(0xFF7E22CE);

  // Neon Och Bardo Soyalar va Nurlar
  static List<BoxShadow> softCardShadow = [
    BoxShadow(
      color: neonBardo.withValues(alpha: 0.08),
      blurRadius: 14,
      offset: const Offset(0, 3),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> hoverCardShadow = [
    BoxShadow(
      color: neonRose.withValues(alpha: 0.35),
      blurRadius: 22,
      spreadRadius: 1,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: neonBardo.withValues(alpha: 0.15),
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> floatingPillShadow = [
    BoxShadow(
      color: neonBardo.withValues(alpha: 0.28),
      blurRadius: 16,
      spreadRadius: 1,
      offset: const Offset(0, 4),
    ),
  ];

  static List<Shadow> neonTextGlow(Color color, {double blur = 10}) => [
    Shadow(color: color.withValues(alpha: 0.75), blurRadius: blur),
    Shadow(color: color.withValues(alpha: 0.35), blurRadius: blur * 2),
  ];
}
