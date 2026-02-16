import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/animated_section.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Duration delay;
  final double fontSize;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.delay = const Duration(milliseconds: 300),
    this.fontSize = 120,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      delay: delay,
      child: RichText(
        text: TextSpan(
          text: "$title\n",
          style: GoogleFonts.urbanist().copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: subtitle,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white.withValues(
                  alpha: 0.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
