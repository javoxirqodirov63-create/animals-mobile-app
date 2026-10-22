import 'package:flutter/material.dart';

class TrustBanner extends StatelessWidget {
  const TrustBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final perks = [
      {
        'emoji': '🛡️',
        'title': 'Tekshirilgan',
        'desc': '100% sara zotlar',
        'iconColor': const Color(0xFFBE123C),
        'bg': const Color(0xFFFFF1F2),
      },
      {
        'emoji': '🩺',
        'title': 'Veterinar nazorati',
        'desc': 'Emlangan & pasportli',
        'iconColor': const Color(0xFF059669),
        'bg': const Color(0xFFDCFCE7),
      },
      {
        'emoji': '⚡',
        'title': 'Tezkor kelishuv',
        'desc': 'To\'g\'ridan-to\'g\'ri aloqa',
        'iconColor': const Color(0xFFD97706),
        'bg': const Color(0xFFFEF3C7),
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(14, 6, 14, 6),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFECDD3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0AB01030),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: perks.map((p) {
          final bg = p['bg'] as Color;
          final iconColor = p['iconColor'] as Color;

          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: iconColor.withValues(alpha: 0.3),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    p['emoji'] as String,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        p['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                          shadows: [
                            Shadow(
                              color: iconColor.withValues(alpha: 0.2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        p['desc'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
