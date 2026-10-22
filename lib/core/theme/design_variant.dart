import 'package:flutter/material.dart';

enum AppDesignVariant {
  cyberNeon,       // ⚡ 1. Och Bardo Neon (Oq Fon & Och Bardo Neon Yozuvlar)
  neoBordeaux,     // 2. Neo-Bordeaux Modern
  swissMinimal,    // 3. Swiss Clean Minimal
  emeraldNature,   // 4. Emerald Agro & Nature
  warmCompanion,   // 5. Warm Honey Companion
}

class DesignThemeConfig {
  final AppDesignVariant variant;
  final String name;
  final String subtitle;
  final String emoji;
  final Color primary;
  final Color primaryAccent;
  final Color background;
  final Color cardColor;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final double cardRadius;
  final String heroTitle;
  final String heroSubtitle;
  final String heroBadge;
  final String heroCtaText;
  final List<BoxShadow> cardShadow;

  const DesignThemeConfig({
    required this.variant,
    required this.name,
    required this.subtitle,
    required this.emoji,
    required this.primary,
    required this.primaryAccent,
    required this.background,
    required this.cardColor,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.cardRadius,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroBadge,
    required this.heroCtaText,
    required this.cardShadow,
  });

  static DesignThemeConfig of(AppDesignVariant variant) {
    switch (variant) {
      case AppDesignVariant.cyberNeon:
        return const DesignThemeConfig(
          variant: AppDesignVariant.cyberNeon,
          name: '1. Och Bardo Neon',
          subtitle: 'Oq Fon & Och Bardo Neon Yozuvlar',
          emoji: '⚡',
          primary: Color(0xFFBE123C), // Jonli Och Bardo
          primaryAccent: Color(0xFFFB7185), // Neon Och Bardo Rose
          background: Colors.white, // TALAB BO'YICHA: TOZA OQ FON
          cardColor: Colors.white, // Oq kartochkalar
          border: Color(0xFFFECDD3), // Och Bardo hoshiya
          textPrimary: Color(0xFF0F172A),
          textSecondary: Color(0xFF64748B),
          cardRadius: 18.0,
          heroTitle: 'Hayvonlaringiz uchun\n100% sara va xavfsiz bozor 🐾',
          heroSubtitle: 'Oq fonda nafis och bardo neon uslubidagi zamonaviy hayvonlar va chorva bozori.',
          heroBadge: '⚡ OCH BARDO NEON • RASMIY BOZOR',
          heroCtaText: 'Jonivorlarni ko\'rish',
          cardShadow: [
            BoxShadow(
              color: Color(0x1FBE123C),
              blurRadius: 18,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        );

      case AppDesignVariant.neoBordeaux:
        return const DesignThemeConfig(
          variant: AppDesignVariant.neoBordeaux,
          name: '2. Neo-Bordeaux',
          subtitle: 'Nafis Bardo & Yevropa andozasi',
          emoji: '🍷',
          primary: Color(0xFF9F1239),
          primaryAccent: Color(0xFFBE123C),
          background: Colors.white,
          cardColor: Colors.white,
          border: Color(0xFFFECDD3),
          textPrimary: Color(0xFF0F172A),
          textSecondary: Color(0xFF64748B),
          cardRadius: 18.0,
          heroTitle: 'Hayvonlaringiz uchun\n100% sara va xavfsiz bozor 🐾',
          heroSubtitle: 'Uy hayvonlari, parrandalar va chorva mollarini ishonchli va xavfsiz xarid qiling.',
          heroBadge: '✨ O\'zbekiston #1 Hayvonlar Bozori',
          heroCtaText: 'Kashf qilish',
          cardShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        );

      case AppDesignVariant.swissMinimal:
        return const DesignThemeConfig(
          variant: AppDesignVariant.swissMinimal,
          name: '3. Swiss Minimal',
          subtitle: 'Ultra-zamonaviy Airbnb & Apple',
          emoji: '⚡',
          primary: Color(0xFF0F172A),
          primaryAccent: Color(0xFF10B981),
          background: Colors.white,
          cardColor: Colors.white,
          border: Color(0xFFE2E8F0),
          textPrimary: Color(0xFF000000),
          textSecondary: Color(0xFF64748B),
          cardRadius: 16.0,
          heroTitle: 'Zamonaviy va Tezkor\nHayvonlar Bozori ⚡',
          heroSubtitle: 'Yuqori sifatli fotosuratlar, to\'g\'ridan-to\'g\'ri aloqa va shaffof narxlar.',
          heroBadge: '⚡ Tezkor & Shaffof Savdo',
          heroCtaText: 'E\'lonlarni ko\'rish',
          cardShadow: [
            BoxShadow(
              color: Color(0x0C0F172A),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        );

      case AppDesignVariant.emeraldNature:
        return const DesignThemeConfig(
          variant: AppDesignVariant.emeraldNature,
          name: '4. Emerald Nature',
          subtitle: 'Yevropa Yashil Tabiat & Chorva',
          emoji: '🌿',
          primary: Color(0xFF047857),
          primaryAccent: Color(0xFF10B981),
          background: Colors.white,
          cardColor: Colors.white,
          border: Color(0xFFCBD5E1),
          textPrimary: Color(0xFF064E3B),
          textSecondary: Color(0xFF475569),
          cardRadius: 16.0,
          heroTitle: 'Tabiiy Nasldor Zotlar\nva Chorva Bozori 🌿',
          heroSubtitle: 'Hisori qo\'chqorlar, zotli sigirlar, otlar va sog\'lom jonivorlar savdosi.',
          heroBadge: '✓ To\'g\'ridan-to\'g\'ri Fermerdan',
          heroCtaText: 'Bozorni ko\'rish',
          cardShadow: [
            BoxShadow(
              color: Color(0x10047857),
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        );

      case AppDesignVariant.warmCompanion:
        return const DesignThemeConfig(
          variant: AppDesignVariant.warmCompanion,
          name: '5. Warm Companion',
          subtitle: 'Mehrli & Do\'stona Uy Hayvonlari',
          emoji: '🐾',
          primary: Color(0xFFD97706),
          primaryAccent: Color(0xFFF59E0B),
          background: Colors.white,
          cardColor: Colors.white,
          border: Color(0xFFEAE3D6),
          textPrimary: Color(0xFF1C1917),
          textSecondary: Color(0xFF57534E),
          cardRadius: 22.0,
          heroTitle: 'Mehrli Jonivorlar\nuchun #1 Xavfsiz Makon 🐾',
          heroSubtitle: 'Mushuklar, kuchuklar, to\'tiqushlar va xonaki jonivorlarni mehr bilan xarid qiling.',
          heroBadge: '🐾 100% Mehrli & Emlangan',
          heroCtaText: 'Do\'st tanlash',
          cardShadow: [
            BoxShadow(
              color: Color(0x0F292524),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        );
    }
  }
}
