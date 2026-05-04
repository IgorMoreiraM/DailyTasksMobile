import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final Widget? action;

  const SectionCard({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 0),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: GoogleFonts.darkerGrotesque(
                    fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark,
                  )),
                  if (subtitle.isNotEmpty)
                    Text(subtitle, style: GoogleFonts.darkerGrotesque(
                      fontSize: 12, color: AppColors.textMuted,
                    )),
                ]),
              ),
              if (action != null) action!,
            ]),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.borderDefault),
          child,
        ],
      ),
    );
  }
}
