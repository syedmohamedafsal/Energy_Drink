import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildAnimatedText(String text, Color color) {
  return AnimatedDefaultTextStyle(
    duration: const Duration(milliseconds: 600),
    style: TextStyle(
      color: color,
      fontSize: 34,
      fontWeight: FontWeight.w800,
      height: 1.1,
      letterSpacing: -1,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    child: Text(text),
  );
}

Widget buildIconButton(IconData icon, Color bgColor, Color iconColor) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 600),
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: bgColor, 
    ),
    child: TweenAnimationBuilder<Color?>(
      duration: const Duration(milliseconds: 600),
      tween: ColorTween(begin: iconColor, end: iconColor),
      builder: (context, color, child) => Icon(icon, color: color, size: 24),
    ),
  );
}

Widget buildStat(String value, String unit, String label, Color color) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 600),
            style: TextStyle(
              color: color,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            child: Text(value),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 600),
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            child: Text(unit),
          ),
        ],
      ),
      AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 600),
        style: TextStyle(
          color: color.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        child: Text(label),
      ),
    ],
  );
}
